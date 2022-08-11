import UIKit

// Объявляем протокол делегата который используется для связи с другими объектами в приложении
protocol IconPickerViewControllerDelegate: AnyObject {
  func iconPicker(_ picker: IconPickerViewController, didPick iconName: String)
}

// Объявляем объект IconPickerViewController который является тэйблвью контроллером
class IconPickerViewController: UITableViewController {
  // Объявляем делегата
  weak var delegate: IconPickerViewControllerDelegate?
  
  // Объявляем массив который содержит список имен иконок. Эти строки также являются
  let icons = ["No Icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"]
  
// MARK: - Делегаты Table View
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return icons.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
    let iconName = icons[indexPath.row]
    cell.textLabel!.text = iconName
    cell.imageView!.image = UIImage(named: iconName)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let delegate = delegate {
      let iconName = icons[indexPath.row]
      delegate.iconPicker(self, didPick: iconName)
    }
  }
}


