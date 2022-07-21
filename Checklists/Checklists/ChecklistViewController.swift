import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
  
  var checklist: Checklist!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Выключаем большой заголовок для навигационного меню
    navigationController?.navigationBar.prefersLargeTitles = false
    
    // Load checklist.items
//    loadChecklistItems()
    
    title = checklist.name
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // 1. Если идентификатор перехода "AddItem", то:
    if segue.identifier == "AddItem" {
      // 2. Устанавливаем контроллер назначения AddItemViewController
      let controller = segue.destination as! ItemDetailViewController
      // 3. Устанавливаем свойство delegate  для контроллера, чтобы узнать когда пользователь нажимает Отмену или Завершено
      controller.delegate = self
      // Если идентификатор перехода "EditItem", то:
    } else if segue.identifier == "EditItem" {
      // Устанавливаем контроллер назначения AddItemViewController
      let controller = segue.destination as! ItemDetailViewController
      // Также устанавливаем свойство delegate для контроллера, чтобы узнать когда пользователь нажмет Отмену или Завершено
      controller.delegate = self
      // Мы находимся внутри метода prepare, параметром которого является sender. Этот параметр содержит ссылку на объект который запустил переход, в нашем случае это ячейка таблицы на которую кликнули.
      // Мы используем этот объект UITableViewCell чтобы найти номер строки просматривая соответствующий индекс используя tableView.indexPath(for:)
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
        controller.itemToEdit = checklist.items[indexPath.row]
      }
    }
  }
  
  // MARK: - Actions
  
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
    // Узнаем текущий индекс для новой строки в массиве checklist.checklist.items
    let newRowIndex = checklist.items.count
    // Добавляем новый экземпляр класса в массив checklist.checklist.items
    checklist.items.append(item)
    // Создаем экземпляр объекта IndexPath, который указывает на новую строку, используя номер строки из константы newRowIndex. Этот объект indexPath сейчас указывает на строку 5(в секции 0)
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    // Следующая строка создает новый, временный массив содержащий всего лишь один объект indexPath.
    let indexPaths = [indexPath]
    // Далее мы используем метод table view - insertRows(at:with:) чтобы сообщить table view о новой строке
    tableView.insertRows(at: indexPaths, with: .automatic)
    // закрываем текущий экран
    navigationController?.popViewController(animated: true)
    
//    saveChecklistItems()
  }
  
  func addItemViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
    // Для того, чтобы создать IndexPath для получения ячейки, мы сперва должны найти номер ячейки для этого экземпляра CheckListItem. Номер ячейки это то же самое, что и индекс экземпляра ChecklistItem в массиве checklist.items - мы можем использовать метод firstIndex(of:) чтобы получить индекс первого элемента массива который соответствует переданному в ChecklisItem. Так как firstIndex(of:) возвращает опционал, то необходимо использовать конструкцию if let.
    if let index = checklist.items.firstIndex(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: item)
      }
    }
    navigationController?.popViewController(animated: true)
    
//    saveChecklistItems()
  }
  
  //MARK: - Table View Data Source
  
  // Запрашиваем количество строк
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return checklist.items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Возвращает предыдущую ячейку которая была использована для ячейки с галочкой
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    
    // Запрашиваем у массива checklist.items объект по текущему индексу, которому соответствует номер строки. Как только находим объект, мы можем обратиться к его свойствам text и checked
    let item = checklist.items[indexPath.row]
    
    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
    return cell
  }
  
  //MARK: - Table View Delegate
  // Проверяем ячейку которая была кликнута
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Если там есть ячейка, присваиваем его константе cell
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = checklist.items[indexPath.row]
      item.checked.toggle()
      configureCheckmark(for: cell, with: item)
    }
    tableView.deselectRow(at: indexPath, animated: true)
    
//    saveChecklistItems()
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // 1
    checklist.items.remove(at: indexPath.row)
    
    // 2
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
    
//    saveChecklistItems()
  }
  

  // Этот метод ищет ячейку с определенной строкой, которая определяется по indexPath и делает галочку видимой если у соответствующей строки статус rowChecked равняется true,  или убирает. For и At являются внешними внешними именами этих параметров.
  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1001) as! UILabel
    
    if item.checked {
      label.text = "√"
    } else {
      label.text = ""
    }
  }
  
  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
}

