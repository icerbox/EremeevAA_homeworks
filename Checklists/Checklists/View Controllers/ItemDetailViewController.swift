import UIKit
import UserNotifications

protocol AddItemViewControllerDelegate: AnyObject {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
  func addItemViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet var shouldRemindSwitch: UISwitch!
  @IBOutlet var datePicker: UIDatePicker!
  
  weak var delegate: AddItemViewControllerDelegate?
  
  var itemToEdit: ChecklistItem?

    override func viewDidLoad() {
      super.viewDidLoad()
      navigationItem.largeTitleDisplayMode = .never
      // Если существует объект ChecklistItem:
      if let item = itemToEdit {
        title = "Edit item"
        textField.text = item.text
        doneBarButton.isEnabled = true
        // Меняем значение переключателя в зависимости от значения свойства shouldRemind. Если пользователь добавляет новую задачу, значение по умолчанию выключено.
        shouldRemindSwitch.isOn = item.shouldRemind
        // Берем дату напоминания из даты дэйтапикера
        datePicker.date = item.dueDate
      }
    }
  
  // Перед тем как стать видимым, вьюконтроллер получает сообщение от viewWIllAppear().
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // Чтобы сделать активным текстфилд мы вводим becomeFirstResponder()
    textField.becomeFirstResponder()
  }
  // MARK: - Actions
  @IBAction func cancel(_ sender: Any) {
    delegate?.itemDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done(_ sender: Any) {
    // Если itemToEdit содержит объект(не является nil), то добавляем текст из текстфилда в существующий экземпляр класса ChecklistItem
    if let item = itemToEdit {
      item.text = textField.text!
      
      item.shouldRemind = shouldRemindSwitch.isOn
      datePicker.timeZone = TimeZone.init(identifier: "UTC")
      item.dueDate = datePicker.date
      
      item.scheduleNotification()
      // и вызываем новый метод делегата
      delegate?.addItemViewController(self, didFinishEditing: item)
      // Иначе, если itemToEdit является пустым (является nil), значит пользователь добавляет новый элемент
    } else {
      // значит создаем новый экземпляр класса ChecklistItem(). Добавляем в него текст который пользователь набрал в текстфилде по умолчанию ставим статус checked: false
      let item = ChecklistItem(text: textField.text!, checked: false)
      
      item.shouldRemind = shouldRemindSwitch.isOn
      item.dueDate = datePicker.date
      
      item.scheduleNotification()
      // и вызываем метод делегата
      delegate?.itemDetailViewController(self, didFinishAdding: item)
    }
  }
  
  @IBAction func shouldRemindToggled(_ switchControl: UISwitch) {
    textField.resignFirstResponder()
    
    if switchControl.isOn {
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options: [.alert, .sound]) {_, _ in
          //do nothing
      }
    }
  }
  
  // MARK: - Table View Delegates
  // Когда пользователь тапает на ячейку, тэйблвью отправляет делегату сообщение willSelectRow, который говорит: "Я собираюсь выбрать эту ячейку". Возвращая значение nil, делегат отвечает: "Извини, но тебе не разрешается тапать"
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
  // MARK: - Text Field Delegates
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
}
