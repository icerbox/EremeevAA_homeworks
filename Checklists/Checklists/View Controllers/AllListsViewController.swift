import UIKit

// Для того, чтобы быть в курсе когда пользователь нажем кнопку назад в навигейшн баре, делаем наш вьюконтроллер делегатом навигационного контроллера подписав под UINavigationControllerDelegate
class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
  
    // Указываем идентификатор кастомной ячейки
    let cellIdentifier = "ChecklistCell"
  
  var dataModel: DataModel!
    
    override func viewDidLoad() {
      super.viewDidLoad()
      // Устанавливаем большой заголовок для навигационного меню
      navigationController?.navigationBar.prefersLargeTitles = true
      
    }
  
  // Этот метод автоматически вызывается после того, как вьюконтроллер становится видимым.
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // Сначала делаем вьюконтроллер делегатом навигационного контроллера
    navigationController?.delegate = self
    // Далее проверяем UserDefaults, если индекс не равен -1 значит выполняем переход. Если значение "Checklistinde" равно -1, значит пользователь был на главном окне, во время закрыти приложения, поэтому мы переход не делаем.
    let index = dataModel.indexOfSelectedChecklist
    if index >= 0 && index < dataModel.lists.count {
      let checklist = dataModel.lists[index]
      performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Объявляем константу которая будет хранить созданную ячейку
      let cell: UITableViewCell!
      // Проверяем сможем ли мы получить ячейку из тэйблвью по выбранному идентификатору.
      // Если есть ячейка назначаем ссылку на ранее объявленную константу
      if let tmp = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
        cell = tmp
      // Если нет ячейки, что означает отсутствие скешированных ячеек для переиспользования, мы создаем новый UITableViewCell экземпляр со стилем ячейки .subtitle и идентификатором cellIdentifier
      } else {
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
      }
      
      // Обновляем информацию в ячейках
      let checklist = dataModel.lists[indexPath.row]
      cell.textLabel!.text = checklist.name
      cell.accessoryType = .detailDisclosureButton
      
      // Вызываем метод countUncheckedItems на объекте Checklist и выводим его в detailTextLabel
      let count = checklist.countUncheckedItems()
      // Если в массиве items нет ни одной задачи, выводим сообщение "Нет задач"
      if checklist.items.count == 0 {
        cell.detailTextLabel!.text = "Нет задач"
      } else {
        // Здесь мы используя тернарные операторы проверяем, если count равно 0 то выводим "Все задачи завершены", если нет то выводим сообщение в detailTextLabel "\(count) осталось"
        // ? - означает true
        // : - иначе
        cell.detailTextLabel!.text = count == 0 ? "Все задачи завершены" : "\(count) осталось"
      }
      // Ячейки использующие стандартный стиль .subtitle имеют встроенный UIImageView с левого края. Добавляем к нему изображение и оно будет автоматически отображено в ячейке.
      cell.imageView!.image = UIImage(named: checklist.iconName)
      return cell
      
    }
    
    // При клике на ячейку выполняем следующие действия:
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      dataModel.indexOfSelectedChecklist = indexPath.row
      
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
      controller.checklistToedit = checklist
      
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
    
    // MARK: - Делегаты ListDetailViewController
    
    // Это методы которые вызываются когда пользователь нажимает отмену или завершено внутри экрана добавить/редактировать
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
      navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
      dataModel.lists.append(checklist)
      dataModel.sortChecklists()
      tableView.reloadData()
      navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
      dataModel.sortChecklists()
      tableView.reloadData()
      navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation Controller Delegates
    // Этот метод вызывается каждый раз когда навигационный контроллер показывает новый экран.
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
      // Была ли нажата кнопка "Назад"
      // Если кнопка назад была нажата, и если был открыт AllListsViewController то меняем значение UserDefaults на -1, что означает что ни один чеклист в данное время не выбран
      // Чтобы определить, является ли AllListsViewController недавно активированным вьюконтроллером пишем:
      if viewController === self {
        dataModel.indexOfSelectedChecklist = -1
      }
    }
}
