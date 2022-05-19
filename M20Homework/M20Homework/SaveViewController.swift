import UIKit
import SnapKit

class SaveViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // Объявляем переменную, в которую передается текущая выбранная строка для редактирования в текущей форме для сохранения
    var rowSelected: Executor?
    
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
    
    // Текстовое поле для ввода имени
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
    
    // Текстовое поле для ввода фамилии
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
    
    // Текстовое поле для ввода даты
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

    // Текстовое поле дял ввода страны
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
    
    // Кнопка "Сохранить"
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func showSavedAlert() {
        let alert = UIAlertController(title: "Изменения сохранены", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { action -> Void in
            self.navigationController?.popViewController(animated: true)
        } ))
        present(alert, animated: true)
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(lastNameField)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(countryField)
        stackView.addArrangedSubview(dateOfBirthField)
        stackView.addArrangedSubview(saveButton)
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

    // Объявляем метод который вызывается при нажатии на кнопку "Сохранить"
    @objc func saveButtonPressed(sender: UIButton!) {
        print("save button pressed")
        guard let newName = nameField.text,
              let newLastName = lastNameField.text,
              let newCountry = countryField.text,
              let newDateOfBirth = dateOfBirthField.text,
              !newName.isEmpty, !newLastName.isEmpty, !newCountry.isEmpty, !newDateOfBirth.isEmpty else {
            return
        }
        updateExecutor(executor: rowSelected!, newName: newName, newLastName: newLastName, newCountry: newCountry, newDateOfBirth: newDateOfBirth)
        showSavedAlert()
    }
    // Метод который обновляет таблицу во ViewController
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
