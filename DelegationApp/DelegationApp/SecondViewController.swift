//
//  SecondViewController.swift
//  DelegationApp
//
//  Created by Андрей Антонен on 18.05.2022.
//

import UIKit

// Создали протокол который свидетельствует о том, что мы хотим делегировать метод fillTheLabelWith(info: String) в другой вьюконтроллер который будет подписан под этот протокол
protocol SecondViewControllerDelegate {
    func fillTheLabelWith(info: String)
}

class SecondViewController: UIViewController {
    
    // У нашего вьюконтроллера SecondViewController есть делегат delegate имеет тип протокола SecondViewControllerDelegate
    var delegate: SecondViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Когда мы нажимаем на sendDataPressed, создается константа info в который сохраняется введенный текст
    @IBAction func sendDataPressed(_ sender: UIButton) {
        let info = textField.text
        // И мы вызываем метод нашего делегата в который мы передаем значение переменной инфо.
        delegate?.fillTheLabelWith(info: info!)
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
