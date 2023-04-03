import Foundation
import UIKit

class MainViewController: UITableViewController {
    var model: [Password]?
    override func viewDidLoad() {
      super.viewDidLoad()
      
      self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FullnameCell")
    }
  
  @IBOutlet weak var fullnameLabel: UIView!
  
  
  // MARK: - Table View Delegates
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an object of the dynamic cell "PlainCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "FullnameCell", for: indexPath)
        // Password selection
        let password = self.model?[indexPath.row]
      guard let newPassword = password else { return UITableViewCell()}
        print("Переменная password \(newPassword)")
        cell.makeCustomText(model: newPassword)
        // Возвращаем сконфигурированную ячейку
        return cell
    }
  
}
