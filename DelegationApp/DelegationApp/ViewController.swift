//
//  ViewController.swift
//  DelegationApp
//
//  Created by Андрей Антонен on 18.05.2022.
//

import UIKit

// Вьюконтроллер ViewController подписан под протокол SecondViewControllerDelegate
class ViewController: UIViewController, SecondViewControllerDelegate {
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func goTo2VCPressed(_ sender: UIButton) {
    }
    
    
    // Кроме того, что вьюконтроллер подписан под протокол SecondViewControllerDelegate когда происходит переход он подписывается под то, что он будет делегатом второго вьюконтроллера
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getDataSegue" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.delegate = self
        }
    }
    
    func fillTheLabelWith(info: String) {
        // В этом методе поле info передается с secondViewController'a
        myLabel.text = info
    }
}

