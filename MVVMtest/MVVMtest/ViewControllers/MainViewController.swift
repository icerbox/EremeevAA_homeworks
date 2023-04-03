//
//  MainViewController.swift
//  MVVMtest
//
//  Created by Айсен Еремеев on 02.04.2023.
//

import UIKit

class MainViewController: UIViewController {
    var didSendEventClosure: ((MainViewController.Event) -> Void)?
    
    private let tableView = UITableView()
    private var isFirst = true
    private var token: String = ""
    private var filesData: DiskResponse?
    private var imagesData: [Images]?

    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 20.0, leading: 20, bottom: 20, trailing: 20.0)
          button.addTarget(MainViewController.self, action: #selector(uploadFile), for: .touchUpInside)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "arrow.down.to.line"), for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    private lazy var fileInfo: FileInfo = {
        let view = FileInfo()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()

    private lazy var urlTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.leftView = spacerView
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.placeholder = "Введите URL для загрузки файла"
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print("MainViewController loaded")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirst {
            updateData()
        }
        isFirst = false
    }

    private func setupViews() {
        title = "Мои фото"
        tableView.dataSource = self
        tableView.register(FileTableViewCell.self, forCellReuseIdentifier: fileCellIdentifier)
//        tableView.backgroundColor = .red
        tableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
          tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
          tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
          tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func updateData() {
        print("Запустился updateData()")
        guard !token.isEmpty else {
          let requestTokenViewController = AuthViewController()
          requestTokenViewController.delegate = self
          requestTokenViewController.modalPresentationStyle = .fullScreen
          present(requestTokenViewController, animated: false, completion: nil)
          return
        }
        print("Токен не пустой идем дальше")
        var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources/files")
        //    components?.queryItems = [URLQueryItem(name: "media_type", value: "image"), URLQueryItem(name: "media_type", value: "book")]
        components?.queryItems = [URLQueryItem(name: "media_type", value: "image,document,book")]
        guard let url = components?.url else { return }
//        print("Сформирована ссылка \(url)")
        var request = URLRequest(url: url)
        request.setValue("OAuth \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self]
          (data, response, error) in
          guard let sself = self, let data = data else { return }
          guard let newFiles = try? JSONDecoder().decode(DiskResponse.self, from: data) else { return }
//          print("Начинаем обрабатывать файлы \(newFiles)")
//          print("Received: \(newFiles.items?.count ?? 0) files")
          sself.filesData = newFiles
          DispatchQueue.main.async { [weak self] in
            print("Обновляем таблицу из главной очереди")
            self?.tableView.reloadData()
          }
        }
        task.resume()
        print("запускаем task.resume")
    }

    @objc private func uploadFile() {
        guard let fileUrl = urlTextField.text, !fileUrl.isEmpty else { return }
        var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources/upload")
        components?.queryItems = [URLQueryItem(name: "url", value: fileUrl),
        URLQueryItem(name: "path", value: "item")
        ]
        guard let url = components?.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("OAuth \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
          if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200..<300:
              print("success")
              self?.updateData()
            default:
              print("Status: \(response.statusCode)")
            }
          }
        }.resume()
    }

    private let fileCellIdentifier = "FileTableViewCell"
    
    deinit {
        print("MainViewController deinit")
    }
    
//    @objc private func didTapLoginButton(_ sender: Any) {
//        didSendEventClosure?(.main)
//    }
}

extension MainViewController {
    enum Event {
        case main
    }
}

extension MainViewController: AuthViewControllerDelegate {
    func handleTokenChanged(token: String) {
        self.token = token
        print("New token: \(token)")
        updateData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filesData?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: fileCellIdentifier, for: indexPath)
        guard let items = filesData?.items, items.count > indexPath.row else {
            return cell
        }
            let currentFile = items[indexPath.row]
        if let fileCell = cell as? FileTableViewCell {
            fileCell.delegate = self
            fileCell.configure(currentFile)
        }
        return cell
    }
}

extension MainViewController: FileTableViewCellDelegate {
    func loadImage(stringUrl: String, completion : @escaping ((UIImage?) -> Void)) {
        // Если url не nil то:
        guard let url = URL(string: stringUrl) else { return }
        // Сохраняем ссылку в переменную request
        var request = URLRequest(url: url)
        // присваиваем значению токен с хидером Authorization
        request.setValue("Oauth \(token)", forHTTPHeaderField: "Authorization")
        // Создаем таск
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          // Если полученные данные не nil, то:
          guard let data = data else { return }
          DispatchQueue.main.async {
            completion(UIImage(data: data))
          }
        }
        task.resume()
    }
}
