import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var occupationField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var URLSessionButton: UIButton!
    @IBOutlet weak var AlamofireButton: UIButton!
    
    override func viewDidLoad() {
        birthField.delegate = self
        super.viewDidLoad()
        URLSessionButton.backgroundColor = UIColor.systemCyan
        AlamofireButton.backgroundColor = UIColor.systemCyan
    }
    private func displaySuccess() {
        let alert = UIAlertController(title: "SUCCESS", message: "Данные успешно отправлены", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func displayFailure() {
        let alert = UIAlertController(title: "FAILURE", message: "Данные не были отправлены", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func urlSessionClick(_ sender: UIButton) {
        // Создаем модель
        let model = Json4Swift_Base(birth: Int("\(birthField.text!)") ?? 0, occupation: occupationField.text!, name: lastNameField.text!, lastname: lastNameField.text!, country: countryField.text!)
            
            let jsonData = try? JSONSerialization.data(
                withJSONObject: [
                model.dictionaryRepresentation()
            ]
        )
        
        // Настраиваем запрос
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Делаем запрос и обрабатываем ответ
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.displayFailure()
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.displaySuccess()
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            
        }.resume()
    }
    
    @IBAction func AlamofireButtonClick(_ sender: UIButton) {
        // Создаем модель
        let item = Item(birth: Int("\(birthField!.text!)") ?? 0, occupation: occupationField.text!, name: nameField.text!, lastname: lastNameField.text!, country: countryField.text!)
        
        AF.request(
           "https://jsonplaceholder.typicode.com/posts",
           method: .post,
           parameters: item,
           encoder: JSONParameterEncoder.default
        ).response { [weak self] response in
            guard response.error == nil else {
                self?.displayFailure()
                return
            }
            self?.displaySuccess()
            debugPrint(response)
        }
    }
    // Объявляем метод который проверяет вводимые в поле "birthField" символы. Разрешены только цифры.
    func textField(_ textField: UITextField, shouldChangeCharactersIn: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
}

