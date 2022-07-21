import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
  func addItemViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
  
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
    weak var delegate: AddItemViewControllerDelegate?
  
  var itemToEdit: ChecklistItem?

    override func viewDidLoad() {
      super.viewDidLoad()
      navigationItem.largeTitleDisplayMode = .never
      
      if let item = itemToEdit {
        title = "Edit item"
        textField.text = item.text
        doneBarButton.isEnabled = true
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
      // и вызываем новый метод делегата
      delegate?.addItemViewController(self, didFinishEditing: item)
      // Иначе, если itemToEdit является пустым (является nil), значит пользователь добавляет новый элемент
    } else {
      // значит создаем новый экземпляр класса ChecklistItem()
      let item = ChecklistItem()
      // добавляем в него текст который пользователь набрал в текстфилде
      item.text = textField.text!
      // и вызываем метод делегата
      delegate?.itemDetailViewController(self, didFinishAdding: item)
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
