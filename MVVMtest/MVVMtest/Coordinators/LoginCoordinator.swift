//
//  LoginCoordinator.swift
//  MVVMtest
//
//  Created by Айсен Еремеев on 29.03.2023.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

class LoginCoordinator: LoginCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showLoginViewController() {
        let loginVC: LoginViewController = .init()
        loginVC.didSendEventClosure = { [weak self] event in
            self?.finish()
        }
        navigationController.pushViewController(loginVC, animated: true)
    }
}
