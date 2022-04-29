import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // Массив путей с картинками
    private let imageURLs = [ "https://cdn.cocoacasts.com/cc00ceb0c6bff0d536f25454d50223875d5c79f1/above-the-clouds.jpg",
        "https://www.slrlounge.com/wp-content/uploads/2016/02/when-to-shoot-hdr.jpg",
        "https://www.slrlounge.com/wp-content/uploads/2016/02/when-to-shoot-hdr.jpg",
        "https://www.slrlounge.com/wp-content/uploads/2016/02/when-to-shoot-hdr.jpg"
    ]
    
    // объявляем массив с данными
    private var images = [Data] ()
    
    // Объявляем стэквью. Переменную делаем lazy чтобы не запускалась каждый раз.
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 20
        return view
    }()
    
    // Добавляем индикатор загрузки, чтобы видеть что мы что-то загружаем из сети
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настраиваем вьюшки
        setupViews()
        
        //загрузка обычным способом
//        asyncUsual()
        
        //загрузка на одной очереди
//        asyncGroup()
        
        //загрузка на разных очередях
        asyncGroup2()
        
    }
    
    private func setupViews() {
        // Добавляем наш стэквью в наш главный вью
        view.addSubview(stackView)
        // Используем снэпкит чтобы добавить констрейнты
        stackView.snp.makeConstraints { make in
            // safeAreaLayoutGuide это безопасная зона, если это нижняя часть bottomMargin, то чуть выше кнопки свернуть, если topMargin то чуть ниже камеры
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalToSuperview()
        }
        // Добавляем в наш стэквью индикатор загрузки
        stackView.addArrangedSubview(activityIndicator)
        // При использовании индикатора загрузки мы должны запустить метод .startAnimating чтобы он появился
        activityIndicator.startAnimating()
    }
    
    private func asyncGroup() {
        print("\n----- asyncGroup ---\n")
        
        let dispatchGroup = DispatchGroup()
        
        //формируем группу асинхронных операций
        for i in 0...3 {
            // Мы создаем группу dispatchGroup  и помещаем в эту группу с помощью метода asyncLoadImage два задания для асинхронной загрузки изображений в очередь
            dispatchGroup.enter()
            asyncLoadImage(imageURL: URL(string: imageURLs[i])!,
                           runQueue: DispatchQueue.global(),
                           completitionQueue: DispatchQueue.main)
            { result, error in
                guard let image1 = result else { return }
                print ("----finished \(i) приоритет = \(qos_class_self().rawValue)")
                self.images.append(image1)
                // после того, как работа завершена, мы вызываем .leave
                dispatchGroup.leave()
            }
        }
        // Когда все задачи в группе будут выполнены, вызывается функци .notify - это блок обратного вызова на всю группу, который помещает все изображения на экране одновременно. Т.е. вызывает наш комплишн, который будет выполнятся на главной очереди
        
        //: ### Блок обратного вызова на всю группу
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.stackView.removeArrangedSubview(self.activityIndicator)
            for i in 0...3 {
                self.addImage(data: self.images[i])
            }
        }
    }
    
    private func asyncGroup2() {
        print("\n----- asyncGroup2 ---\n")
        let dispatchGroup = DispatchGroup()
        // Создаем дополнительную последовательную очередь
        let queue = DispatchQueue(label: "com.skillbox.queues.serial")
        
        for i in 0...1 {
            dispatchGroup.enter()
            asyncLoadImage(imageURL: URL(string: imageURLs[i])!,
                           runQueue: queue,
                           completitionQueue: DispatchQueue.main)
            {   [weak self] result, error in
                guard let self = self else { return }
                guard let image1 = result else { return }
                self.images.append(image1)
                print("изображение \(i) приоритет = \(qos_class_self().rawValue)")
                dispatchGroup.leave()
            }
        }
        
        for i in 2...3 {
            DispatchQueue.global(qos: .userInitiated).async(group: dispatchGroup) { [weak self] in
                guard let self = self else { return }
                let url = URL(string: self.imageURLs[i])
                let data = try? Data(contentsOf: url!)
                sleep(arc4random() % 4)
                self.images.append(data!)
                              print("изображение \(i) приоритет = \(qos_class_self().rawValue)")
            }
        }
    
    // Задаем замыкание, которое будет вызвано по завершению всех задач
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.stackView.removeArrangedSubview(self.activityIndicator)
            for i in 0...3 {
                self.addImage(data: self.images[i])
            }
        }
    }
    
    // Обычная загрузка
    func asyncUsual () {
        print("\n----- asyncUsual ---\n")
        // Циклом проходимся по массиву изображений
        for i in 0...3 {
            // Создаем url из массива, для текущей итерации
            let url = URL(string: imageURLs[i])
            // Создаем запрос из сформированной ссылки
            let request = URLRequest(url: url!)
            // Создаем задачу task
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) -> Void in
                // Указываем что мы хотим обрабатывать его на главной очереди асинхронно
                DispatchQueue.main.async { [weak self] in
                    // Проверяем если запрос был долгий и за это время пользователь ушел с нашего экрана и вьюконтроллер деинициализировался, соответственно второй self у нас превратился в nil то возвращаем return
                    guard let self = self else { return }
                    // Если все в порядке, то печатаем какое изображение загрузилось
                    print ("изображение \(i)")
                    // и при помощи нашего вспомогательного изображения добавляем изображение в стэк
                    self.addImage(data: data!)
                }
            }
            // Чтобы задача запустилась, мы должны вызвать метод .resume
            task.resume()
        }
    }
}

private extension ViewController {
    // Метод для асинхронной загрузки изображений.
    func asyncLoadImage(
        // Пусть по которому лежит наше изображение
        imageURL: URL,
        // Очередь на которую мы будем делать нашу работу
        runQueue: DispatchQueue,
        // Очередь на которую мы вызовем обработку результатов
        completitionQueue: DispatchQueue,
        // Обработчик передаваемых замыканий. Если мы получаем данные то получаем Data, если nil то Error
        completition: @escaping (Data?, Error?) -> ()
    ) {
        // в теле метода содержится очередь на которую мы будем выполнять асинхронную работу
        runQueue.async {
            do {
                // Если нам удалось загрузить изображение, то идем дальше
                let data = try Data(contentsOf: imageURL)
                    // sleep останавливает очередь на заданное время
                    // arc4random дает нам рандомное время
                    sleep(arc4random() % 4)
                completitionQueue.async { completition(data, nil) }
                // Если произошла ошибка мы проваливаемся в этот блок и у нас срабатывает ошибка
            } catch let error {
                completitionQueue.async { completition(nil, error) }
            }
        }
    }
    
    // Метод addImage берет дату и с помощью него создает изображения UIImageView. Создает вью и добавляет его в наш стэквью.
    func addImage(data: Data) {
        let view = UIImageView(image: UIImage(data: data))
        view.contentMode = .scaleAspectFit
        self.stackView.addArrangedSubview(view)
    }
}
