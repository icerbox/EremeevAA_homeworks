import UIKit

class FindViewController: UIViewController {
  
  // Указываем идентификатор кастомной ячейки
  let customTableViewCell = "customViewCell"
  
  // Объявляем строку для поиска
  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.searchBarStyle = UISearchBar.Style.default
    searchBar.placeholder = "Введите данные сотрудника"
    searchBar.sizeToFit()
    searchBar.isTranslucent = false
    return searchBar
  }()
    
  // Создаем аутлет для программной обработки значений фамилии введенных пользователем в текстфилд.
    @IBOutlet weak var fullnames: UITextField!
    let model = PasswordsModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
    }
  // Затем, создается экшн функция для обработки функциональности после клика пользователся на кнопку findPasswords. После того как пользователь введет фамилию и кликнет на кнопку "Найти контакты", метод findPasswords создаст параметры которые будут переданы в метод downloadPasswords из модели PasswordsModel
    @IBAction func findPasswords(_ sender: Any) {
        let param = ["fullname": self.fullnames.text!]
      model.downloadPasswords(parameters: param, url: URLServices.passwords)
    }
}

// Вьюконтроллер должен принимать протокол Downloadable чтобы хранить в модели декодированные данные после того как пользователь кликнет на кнопку "Найти контакты". Чтобы он принимал этот протокол, мы создаем экстеншн Вьюконтроллера который реализует метод didRecieveData() из нашего протокола.
extension FindViewController: Downloadable { // implements our Downloadable protocol
    func didReceiveData(data: Any) {
      print(data)
        // Данные к этому моменту уже загружены
        // Теперь передаем модель данных в TableViewController Passwords
       DispatchQueue.main.sync {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainTableID") as! MainViewController
            mainViewController.model = (data as! [Password])
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
}
