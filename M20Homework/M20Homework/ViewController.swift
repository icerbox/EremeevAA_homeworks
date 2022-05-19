
import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Получаем данные сортировки полей из UserDefaults
        showFromUserDefaults()
        title = "Список исполнителей"
        // Запускаем метод который отображает всех исполнителей
        getAllExecutors()
        setupViews()
        tableView.delegate = self
        tableView.dataSource = self
        // Создаем кнопку для вызова формы добавления новых исполнителей
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // Объявляем UITableView
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ExecutorsCell.self, forCellReuseIdentifier: "cell")
        table.register(ExecutorsCell.self, forCellReuseIdentifier: ExecutorsCell.identifier)
        return table
    }()
    
    // Объявляем стэквью
    lazy var stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Объявляем стэквью для кнопок
    lazy var stackView2: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Кнопка "Сортировать в алфавитном порядке"
    
    lazy var ascendingButton: UIButton = {
        let button = UIButton()
        button.setTitle("В алфавитном", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(ascendingButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // Кнопка "Сортировать в обратном алфавитном порядке"
    
    lazy var descendingButton: UIButton = {
        let button = UIButton()
        button.setTitle("В обратном", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(descendingButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // Объявляем массив в который будем добавлять исполнителей
    var models = [Executor]()
    
    // Объявляем ячейку которой будет назначаться текущая выбранная строка в таблице исполнителей. Это необходимо для открытия выбранной строки во вьюконтроллере для редактирования данных SaveViewController
    var executor: Executor?
    
    // Объявляем экземпляр класса UserDefaults
    let defaults = UserDefaults.standard
    
    // Глобальная переменная для сохранения сортировки
    var globalFetchRequest = NSFetchRequest<Executor>()
    
    // Сохраняем порядок сортировки в UserDefaults в виде архива
    func saveIntoUserDefaults() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: globalFetchRequest, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "sortingOrder")
            print("Сохранено в userDefaults")
        }
    }
    // Получаем данные сортировки из UserDefaults
    func showFromUserDefaults() {
        if let savedModels = defaults.object(forKey: "sortingOrder") as? Data {
            if let decodedModels = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedModels) as? NSFetchRequest<Executor> {
                globalFetchRequest = decodedModels
                print("Показали из userDefaults")
            }
        }
    }
    
    // При загрузке вью обновляем таблицу с исполнителями. Это нужно для обновления данных в таблице после изменения значений в других формах
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear сработал")
        getAllExecutors()
    }
    
    // Объявляем метод при нажатии кнопки "Add"
    @objc private func didTapAdd() {
        self.performSegue(withIdentifier: "addViewControllerSegue", sender: self)
    }
    
    // Количество строк устанавливаем равным количеству элементов в массиве models
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    // Настраиваем отображение ячеек в tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExecutorsTableViewCell", for: indexPath) as! ExecutorsCell
        // Назначаем лейблам которые отображатся на tableVIew данные из coreData. lastName.text, name.text это лейблы из ExecutorCell.
        cell.lastName.text = model.lastName
        cell.name.text = model.name
        cell.country.text = model.country
        cell.dateOfBirth.text = model.dateOfBirth
        cell.configure()
        return cell
    }
    
    // Подготоваливаем настройки перехода которые сработают при переходе на другие вьюконтроллеры
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // При нажатии на кнопку "Редактировать" переходим во вьюконтроллер SaveViewController и выполняем следующие действия:
        if segue.identifier == "saveViewControllerSegue" {
            if let saveViewController = segue.destination as? SaveViewController {
                // Назначаем данные текущей выбранной строки переменной rowSelected вьюконтроллера SaveViewController
                saveViewController.rowSelected = executor
                // Передаем поле "Имя"
                saveViewController.nameField.text = self.executor!.name
                // Передаем поле "Фамилия"
                saveViewController.lastNameField.text = self.executor!.lastName
                // Передаем поле "Страна"
                saveViewController.countryField.text = self.executor!.country
                // Передаем поле "Дата рождения"
                saveViewController.dateOfBirthField.text = self.executor!.dateOfBirth
            }
        }
    }
    
    // При клике на ячейку выполняем следующие действия:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Назначаем глобальной переменной executor значение выделенной строки
        executor = models[indexPath.row]
        // Выводим алерт со вкладками "Редактировать", "Отменить", "Удалить"
        let sheet = UIAlertController(title: "Редактировать",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        // Добавляем действие при нажатии на кнопку "Редактировать":
        sheet.addAction(UIAlertAction(title: "Редактировать", style: .default, handler: {_ in
            // Выполняем переход с идентификатором saveViewControllerSegue
            self.performSegue(withIdentifier: "saveViewControllerSegue", sender: self)
        }))
        // Добавляем действие при нажатии на кнопку "Удалить"
        sheet.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] _ in
            // Выполняем метод deleteExecutor и указываем текущую выбранную строку
            self?.deleteExecutor(executor: (self?.executor)!)
        }))
        // Показываем алерт
        present(sheet, animated: true)
    }
    
    
    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(stackView2)
        // добавляем UITableView
        stackView.addArrangedSubview(tableView)
        stackView2.addArrangedSubview(ascendingButton)
        stackView2.addArrangedSubview(descendingButton)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(stackView2.snp.bottom)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
        }
        stackView2.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20.0)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-5.0)
            make.bottom.equalTo(stackView.snp.top).offset(-20.0)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(5.0)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top)
            make.right.equalTo(stackView.snp.right)
            make.bottom.equalTo(stackView.snp.bottom)
            make.left.equalTo(stackView.snp.left)
        }
        ascendingButton.snp.makeConstraints { make in
        }
        descendingButton.snp.makeConstraints { make in
        }
    }
    
    // Объявляем метод который отображает всех исполнителей
    func getAllExecutors() {
        do {
            globalFetchRequest.entity = Executor.entity()
            models = try context.fetch(globalFetchRequest)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            // error
        }
    }
    
    func getAllExecutorsAscending() {
        do {
            globalFetchRequest.entity = Executor.entity()
            // Устанавливаем алфавитный порядок сортировки
            globalFetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
            models = try context.fetch(globalFetchRequest)
            saveIntoUserDefaults()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            // error
        }
    }
    func getAllExecutorsDescending() {
        do {
            globalFetchRequest.entity = Executor.entity()
            // Устанавливаем сортировку в обратном алфавитном порядке
            globalFetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: false)]
            models = try context.fetch(globalFetchRequest)
            saveIntoUserDefaults()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            // error
        }
    }
    
    // Объявляем метод который добавляет новых исполнителей
    func createExecutor(name: String, lastName: String, dateOfBirth: String, country: String) {
        let newExecutor = Executor(context: context)
        newExecutor.name = name
        newExecutor.lastName = lastName
        newExecutor.dateOfBirth = dateOfBirth
        newExecutor.country = country
        do {
            try context.save()
            getAllExecutors()
        }
        catch {
        }
    }
    // Объявляем метод который удаляет текущего исполнителя
    func deleteExecutor(executor: Executor) {
        context.delete(executor)
        do {
            try context.save()
            getAllExecutors()
        }
        catch {
        }
    }
    
    // MARK: - Core Data
    
    // Объявляем метод который обновляет текущего исполнителя
    
    func updateExecutor(executor: Executor, newName: String, newLastName: String, newCountry: String, dateOfBirth: String) {
        executor.name = newName
        executor.lastName = newLastName
        executor.country = newCountry
        executor.dateOfBirth = dateOfBirth
        do {
            try context.save()
            getAllExecutors()
        }
        catch {
        }
    }
    
    // Метод который запускается при нажатии на кнопку "Сортировать в алфавитном порядке"
    @objc func ascendingButtonPressed(sender: UIButton!) {
        getAllExecutorsAscending()
        self.dismiss(animated: true, completion: nil)
    }
    // Метод который запускается при нажатии на кнопку "Сортировать в обратном алфавитном порядке"
    @objc func descendingButtonPressed(sender: UIButton!) {
        getAllExecutorsDescending()
        self.dismiss(animated: true, completion: nil)
    }
}
