//
//  SecondViewController.swift
//  Lesson17-9
//
//  Created by Андрей Антонен on 03.02.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for i in 0...2000000 {
//            print(i)
//        }
        
        
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 200000) {
//                print("\($0) times")
//                print(Thread.current)
//            }
//        }
        myInactiveQueue()
        
    }
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "IceR", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("Done!")
        }
        
        print("not yet started...")
        inactiveQueue.activate()
        print("activated!")
        inactiveQueue.suspend()
        print("Paused!")
        inactiveQueue.resume()
    }
}
