import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
  
    // Указываем идентификатор кастомной ячейки
    let cellIdentifier = "ChecklistCell"
  
  var dataModel: DataModel!
    
    override func viewDidLoad() {
      super.viewDidLoad()
      // Устанавливаем большой заголовок для навигационного меню
      navigationController?.navigationBar.prefersLargeTitles = true
      
      // Регистрируем идентификатор кастомной ячейки к тэйблвью, чтобы тэйблвью знал какой класс ячеек использовать для создания новых ячеек в таблице.
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

    }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel.lists.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    // Update cell information
    let checklist = dataModel.lists[indexPath.row]
    cell.textLabel!.text = checklist.name
    cell.accessoryType = .detailDisclosureButton
    return cell
  }
  
  // При клике на ячейку выполняем следующие действия:
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let checklist = dataModel.lists[indexPath.row]
    // Выполняем метод performSegue для перехода с идентификатором "ShowChecklist". У метода есть параметра sender, который указывает на объект отправляемый при переходе. Помещение объекта Checklist в параметр sender еще не передает его в ChecklistViewController. Это делается в prepare-for-segue.
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }
  
  // Добавляем метод источника данных тэйблвью, который позволяет удалять чеклисты
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    dataModel.lists.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  // В этом методе создается объект вьюконтроллера для экрана добавить/редактировать и добавляет его в навигационные стек.
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
    controller.delegate = self
    
    let checklist = dataModel.lists[indexPath.row]
    controller.checkListToedit = checklist
    
    navigationController?.pushViewController(controller, animated: true)
  }
  
  // Здесь настраиваются свойства вьюконтроллера перед тем как выполнится переход к нему:
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowChecklist" {
      // Объявляем константу которой назначаем вьюконтроллер назначения
      let controller = segue.destination as! ChecklistViewController
      // И присваиваем его свойству checklist данные кликнутой ячейки "sender: checklist" которые описаны в didSelectRowAt
      controller.checklist = sender as? Checklist
    } else if segue.identifier == "AddChecklist" {
      let controller = segue.destination as! ListDetailViewController
      controller.delegate = self
    }
  }
  
  // MARK: - List Detail View Controller Delegates
  
  // Это методы которые вызываются когда пользователь нажимает отмену или завершено внутри экрана добавить/редактировать
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
    let newRowIndex = dataModel.lists.count
    dataModel.lists.append(checklist)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
    if let index = dataModel.lists.firstIndex(of: checklist) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        cell.textLabel!.text = checklist.name
      }
    }
    navigationController?.popViewController(animated: true)
  }
  
}
