import UIKit

protocol ListDetailViewControllerDelegate: AnyObject {
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
  @IBOutlet var textField: UITextField!
  @IBOutlet var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var iconImage: UIImageView!
  
  
  weak var delegate: ListDetailViewControllerDelegate?
  
  var checklistToedit: Checklist?
  
  // Объявляем переменную для отслеживания выбранного имени иконки
  var iconName = "Folder"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    if let checklist = checklistToedit {
      title = "Edit Checklist"
      textField.text = checklist.name
      doneBarButton.isEnabled = true
      // Если опционал checklistToEdit не является nil, то копируем имя иконки в переменную экземпляра iconName
      iconName = checklist.iconName
    }
    // Загружаем изображение иконки в новый объект UIImage и назначаем изображение ячейки для показа
    iconImage.image = UIImage(named: iconName)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PickIcon" {
      let controller = segue.destination as! IconPickerViewController
      controller.delegate = self
    }
  }
  
  // MARK: - Actions
  
  @IBAction func cancel() {
    delegate?.listDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    if let checklist = checklistToedit {
      checklist.name = textField.text!
      checklist.iconName = iconName
      delegate?.listDetailViewController(self, didFinishEditing: checklist)
    } else {
      let checklist = Checklist(name: textField.text!, iconName: iconName)
      delegate?.listDetailViewController(self, didFinishAdding: checklist)
    }
  }
  
  
  // MARK: - Table View Delegates
  // Чтобы пользователь не мог кликать по ячейкам таблицы с текстфилдом, пишем return nil
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    // Разрешаем пользователю тапать на ячейку иконки, и возвращаем indexPath для этой ячейки.
    return indexPath.section == 1 ? indexPath : nil
  }
    
  // MARK: Text Field Delegates
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    // Если введенный текст не пустой, то активируем кнопку Done
    doneBarButton.isEnabled = !newText.isEmpty
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    doneBarButton.isEnabled = false
    return true
  }
  
  // MARK: - Icon Picker View COntroller Delegate
  
  func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
    // Вкладываем имя выбранной иконки в переменную iconName чтобы запомнить его
    self.iconName = iconName
    // И обновляем imageView с новой картинкой
    iconImage.image = UIImage(named: iconName)
    // После этого убираем Picker View Controller с навигационного стека
    navigationController?.popViewController(animated: true)
  }
}
