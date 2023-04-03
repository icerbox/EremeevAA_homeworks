//
//  AppCoordinator.swift
//  MVVMtest
//
//  Created by Айсен Еремеев on 29.03.2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
    func showAuthPage()
    func showMainViewController()
}

class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .app }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        showLoginFlow()
    }
    
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator.init(navigationController)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }

    func showMainFlow() {
        print("запускаем showMainFlow из AppCoordinator.swift")
        let tabCoordinator = TabCoordinator.init(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
    
    func showMainViewController() {
        let mainViewCoordinator = MainViewCoordinator.init(navigationController)
        mainViewCoordinator.finishDelegate = self
        mainViewCoordinator.start()
        childCoordinators.append(mainViewCoordinator)
        
    }

    func showAuthPage() {
        let authViewCoordinator = AuthViewCoordinator.init(navigationController)
        authViewCoordinator.finishDelegate = self
        authViewCoordinator.start()
        childCoordinators.append(authViewCoordinator)
    }
    
    func showOnboardingPage() {
        let authViewCoordinator = AuthViewCoordinator.init(navigationController)
        authViewCoordinator.finishDelegate = self
        authViewCoordinator.start()
        childCoordinators.append(authViewCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        
        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
            
            showLoginFlow()
        case .login:
            navigationController.viewControllers.removeAll()
            showAuthPage()
        case .auth:
            navigationController.viewControllers.removeAll()
//            showOnboardingPage()
//            showMainViewController()
            print("запустился кейс .auth из AppCoordinator")
        case .main:
            navigationController.viewControllers.removeAll()
            print("запустился кейс .main из AppCoordinator")
            showMainViewController()
        default:
            break
        }
    }
}









