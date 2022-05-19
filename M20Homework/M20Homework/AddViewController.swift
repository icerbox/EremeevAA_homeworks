
import UIKit
import SnapKit

class AddViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Объявляем экземпляр основного вьюконтроллера
    let firstViewController = ViewController()
    
    // Объявляем стэквью
    lazy var stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 20
        return view
    }()
    
    // Текстовое поле для имени
    lazy var nameField: UITextField = {
        let nameField = UITextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "Введите имя"
        nameField.borderStyle = UITextField.BorderStyle.roundedRect
        nameField.keyboardType = UIKeyboardType.default
        nameField.returnKeyType = UIReturnKeyType.done
        nameField.autocorrectionType = UITextAutocorrectionType.no
        nameField.clearButtonMode = UITextField.ViewMode.whileEditing
        nameField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nameField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        nameField.textAlignment = .center
        return nameField
    }()
    
    // Текстовое поле для фамилии
    lazy var lastNameField: UITextField = {
        let nameField = UITextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "Введите фамилию"
        nameField.borderStyle = UITextField.BorderStyle.roundedRect
        nameField.keyboardType = UIKeyboardType.default
        nameField.returnKeyType = UIReturnKeyType.done
        nameField.autocorrectionType = UITextAutocorrectionType.no
        nameField.clearButtonMode = UITextField.ViewMode.whileEditing
        nameField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nameField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        nameField.textAlignment = .center
        return nameField
    }()
    
    // Текстовое поле для даты рождения
    lazy var dateOfBirthField: UITextField = {
        let nameField = UITextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "Введите дату рождения"
        nameField.borderStyle = UITextField.BorderStyle.roundedRect
        nameField.keyboardType = UIKeyboardType.default
        nameField.returnKeyType = UIReturnKeyType.done
        nameField.autocorrectionType = UITextAutocorrectionType.no
        nameField.clearButtonMode = UITextField.ViewMode.whileEditing
        nameField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nameField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        nameField.textAlignment = .center
        return nameField
    }()
    
    // Текстовое поле для страны
    lazy var countryField: UITextField = {
        let nameField = UITextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "Введите страну"
        nameField.borderStyle = UITextField.BorderStyle.roundedRect
        nameField.keyboardType = UIKeyboardType.default
        nameField.returnKeyType = UIReturnKeyType.done
        nameField.autocorrectionType = UITextAutocorrectionType.no
        nameField.clearButtonMode = UITextField.ViewMode.whileEditing
        nameField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nameField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        nameField.textAlignment = .center
        return nameField
    }()
    
    // Кнопка "Добавить"
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(lastNameField)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(countryField)
        stackView.addArrangedSubview(dateOfBirthField)
        stackView.addArrangedSubview(addButton)
        stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        nameField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
        lastNameField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
        dateOfBirthField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
        countryField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
    }
    
    private func showAddedAlert() {
        let alert = UIAlertController(title: "Исполнитель добавлен", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { action -> Void in
            self.navigationController?.popViewController(animated: true)
        } ))
        present(alert, animated: true)
    }
    
    // Метод который запускается при нажатии на кнопку "Добавить"
    @objc func addButtonPressed(sender: UIButton!) {
        print("add button pressed")
        guard let newName = nameField.text,
              let newLastName = lastNameField.text,
              let newCountry = countryField.text,
              let newDateOfBirth = dateOfBirthField.text,
              !newName.isEmpty, !newLastName.isEmpty, !newCountry.isEmpty, !newDateOfBirth.isEmpty else {
            return
        }
        createExecutor(name: newName, lastName: newLastName, country: newCountry, dateOfBirth: newDateOfBirth)
        showAddedAlert()
    }
    
    // Метод который обновляет таблицу в основном вьюконтроллере
    func getAllExecutors() {
        do {
            self.firstViewController.models = try context.fetch(Executor.fetchRequest())
            DispatchQueue.main.async {
                self.firstViewController.tableView.reloadData()
            }
        }
        catch {
            // error
        }
    }

    // Объявляем метод который добавляет новых исполнителей
    func createExecutor(name: String, lastName: String, country: String, dateOfBirth: String) {
        let newExecutor = Executor(context: context)
        newExecutor.name = name
        newExecutor.lastName = lastName
        newExecutor.country = country
        newExecutor.dateOfBirth = dateOfBirth
        do {
            try context.save()
            getAllExecutors()
            print("Обновление с функции createExecutor")
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
    
    func updateExecutor(executor: Executor, newName: String, newLastName: String, newCountry: String, newDateOfBirth: String) {
        executor.name = newName
        executor.lastName = newLastName
        executor.country = newCountry
        executor.dateOfBirth = newDateOfBirth
        do {
            try context.save()
            getAllExecutors()
        }
        catch {
        }
    }
}
