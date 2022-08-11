import Foundation
import UIKit

class MainViewController: UITableViewController {
    var model: [Password]?
    override func viewDidLoad() {
      super.viewDidLoad()
      
//      self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FullnameCell")
    }
  
  @IBOutlet weak var fullnameLabel: UIView!
  
  
  // MARK: - Table View Delegates
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        guard let _ = self.model else {
//            return 0
//        }
//        return self.model!.count
      return 8
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // Create an object of the dynamic cell "PlainCell"
//        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
//        // Password selection
//        let password = self.model![indexPath.row]
//        print("Переменная password \(password)")
//        cell.makeCustomText(model: password)
//        // Возвращаем сконфигурированную ячейку
//        return cell
//    }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FullnameCell", for: indexPath)
    
    let label = cell.viewWithTag(1000) as! UILabel

    if indexPath.row == 0 {
      label.text = "Walk the dog"
    } else if indexPath.row == 1 {
      label.text = "Brush my teeth"
    } else if indexPath.row == 2 {
      label.text = "Learn iOS development"
    } else {
      label.text = "Dummy text"
    }
    
    return cell
  }
  
}
