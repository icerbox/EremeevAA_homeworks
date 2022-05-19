//
//  ViewController.swift
//  M19
//
//  Created by Андрей Антонен on 11.03.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func sendRequestWithAlamoFire() {
        let item = Item(id: 0, title: titleString)
        
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
    
    func sendRequestWithURLSession(jsonData: Data) {
        // Создаем модель
        let model1 = Json4Swift_Base(id: 1, title: "Title One")
        let model2 = Json4Swift_Base(id: 2, title: "Title Two")
        let model3 = Json4Swift_Base(id: 3, title: "Title Two")
        
        // Превращаем в JSON
        let jsonData = try? JSONSerialization.data(
            withJSONObject: [
                model1.dictionaryRepresentation(),
                model2.dictionaryRepresentation(),
                model3.dictionaryRepresentation()
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
    
    private func displaySuccess() {
        resultLabel.textColor = .systemGreen
        resultLabel.text = "Success"
    }
    private func displayFailure() {
        resultLabel.textColor = .systemRed
        resultLabel.text = "Failure"
    }
    @IBAction func onEndEditing(_ sender: UITextField) {
        titleString = sender.text ?? ""
    }
    @IBAction func onSendButton(_ sender: Any) {
        sendRequestWithAlamoFire()
    }
    
    
}










