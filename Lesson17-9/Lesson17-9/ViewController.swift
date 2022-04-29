//
//  ViewController.swift
//  Lesson17-9
//
//  Created by Андрей Антонен on 03.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        afterBlock(seconds: 2, queue: .global()) {
//            print("Hello")
//            print(Thread.current)
//        }
        
//        afterBlock(seconds: 2) {
//            print("Hello")
//            self.showAlert()
//            print(Thread.current)
//        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping()->()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }
}
