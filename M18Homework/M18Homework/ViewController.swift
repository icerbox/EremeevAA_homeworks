import UIKit
import SnapKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    // Указываем идентификатор кастомной ячейки
    
    let customTableViewCell = "customTableViewCell"
    
    // Объявляем переменную которой будет
    
    var clickedMovie: APIResponseResults?
    
    var clickedMovieImage: Images?
    // Объявляем SearchBar
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    // Оьъявлявем индикатор загрузки
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.center = self.view.center
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // объявляем тэйблвью
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // регистрируем нашу кастомную ячейку
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customTableViewCell")
        // устанавливаем высоту ячейки
        tableView.rowHeight = 170
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    // После загрузки вью в память выполняем следующие действия

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // указываем источник даты
        tableView.dataSource = self
        // указываем делегата
        tableView.delegate = self
        // добавляем вьюшки
        setupViews()
        // устанавливаем констрейнты
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear сработал")
        getAllMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieInfo" {
            if let movieInfoViewController = segue.destination as? MovieInfoViewController {
                movieInfoViewController.rowSelected = clickedMovie
                movieInfoViewController.imageSelected = clickedMovieImage
                movieInfoViewController.cellImage.image = self.clickedMovieImage?.imageCell
                print("Изображение: \(String(describing: clickedMovieImage))")
                movieInfoViewController.cellTitle.text = self.clickedMovie!.title
                movieInfoViewController.cellDescription.text = self.clickedMovie!.description
            }
        }
    }
    // MARK: - Private
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        view.addSubview(activityIndicator)
    }
    
    // Констрейнты тэйблвью устанавливаем при помощи SnapKit
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view)
            make.left.equalTo(view)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.right.equalTo(view)
            make.left.equalTo(view)
            make.bottom.equalTo(view)
        }
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Перед поиском очищаем массив фильмов и изображений
        moviesArray = []
        imagesArray = []
        getAllMovies()
        // Запускаем индикатор загрузки
        self.activityIndicator.startAnimating()
        // Запускаем метод для загрузки данных
        getData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    // Объявляем метод для загрузки данных
    
    func getData() {
        let urlString = URL(string: "https://imdb-api.com/en/API/Search/k_rfa65i44/" + searchBar.text!)
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = urlString else {
                return
            }
            let task = URLSession.shared.dataTask(with: url, completionHandler: {
                data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                var result: APIResponse?
                do {
                    result = try JSONDecoder().decode(APIResponse.self, from: data)
                }
                catch {
                    print("Failed to decode with error: \(error)")
                }
                guard let final = result else {
                    return
                }
                for i in final.results {
                    moviesArray.append(APIResponseResults(description: i.description, id: i.id, image: i.image, resultType: i.resultType, title: i.title))
                    loadImage(urlString: i.image)
                }
                DispatchQueue.main.async {
                    print("call to reload data")
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            })
            task.resume()
            
        }
       
    }
    
    // Указываем количество ячеек равным количеству элементов в массиве data
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    // Настраиваем ячейки для тэйблвью
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // инициализируем кастомную ячейку
        let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCell) as? CustomTableViewCell
        // объявляем вьюмодель равной элементам массива data
        let viewModel = moviesArray[indexPath.row]
        let imageModel = imagesArray[indexPath.row]
        // настраиваем вьюмодель
        cell?.configure(viewModel, imageModel)
        // возвращаем ячейки
        return cell ?? UITableViewCell()
    }
    
    //  При клике на ячейку выполняем следующие действия
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        clickedMovie = moviesArray[indexPath.row]
        clickedMovieImage = imagesArray[indexPath.row]
        self.performSegue(withIdentifier: "showMovieInfo", sender: self)
    }
    
    func getAllMovies() {
        do {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
    }

extension ViewController: UITableViewDelegate {}
