import Foundation
import UIKit

class MainViewController: UITableViewController {
    var model: [Password]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let _ = self.model else {
            return 0
        }
        return self.model!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an object of the dynamic cell "PlainCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        // Password selection
        let password = self.model![indexPath.row]
        print("Переменная password \(password)")
        cell.makeCustomText(model: password)
        // Возвращаем сконфигурированную ячейку
        return cell
    }
}
