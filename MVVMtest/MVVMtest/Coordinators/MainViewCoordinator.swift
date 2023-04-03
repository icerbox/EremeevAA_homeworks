//
//  MainViewCoordinator.swift
//  MVVMtest
//
//  Created by Айсен Еремеев on 02.04.2023.
//

import Foundation
import UIKit

protocol MainViewCoordinatorProtocol: Coordinator {
    func showMainViewController()
}

class MainViewCoordinator: MainViewCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .main }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainViewController()
    }
    
    deinit {
        print("MainViewCoordinator deinit")
    }
    
    func showMainViewController() {
        let mainVC: MainViewController = .init()
        mainVC.didSendEventClosure = { [weak self] event in
            self?.finish()
        }
        navigationController.pushViewController(mainVC, animated: true)
    }
    
}
