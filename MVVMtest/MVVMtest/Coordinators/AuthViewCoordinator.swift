//
//  AuthViewCoordinator.swift
//  MVVMtest
//
//  Created by Айсен Еремеев on 30.03.2023.
//

import Foundation
import UIKit

protocol AuthViewCoordinatorProtocol: Coordinator {
    func showAuthViewController()
}

class AuthViewCoordinator: AuthViewCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .main }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAuthViewController()
    }
    
    deinit {
        print("AuthCoordinator deinit")
    }
    
    func showAuthViewController() {
        let authVC: AuthViewController = .init()
        authVC.didSendEventClosure = { [weak self] event in
            self?.finish()
        }
        navigationController.pushViewController(authVC, animated: true)
    }
    
}
