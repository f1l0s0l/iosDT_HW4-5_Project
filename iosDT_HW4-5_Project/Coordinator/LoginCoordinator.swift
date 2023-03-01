//
//  LoginCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

protocol CoordinatbleLogin: AnyObject {
    func switchToMainTabBarCoordinator()
}

final class LoginCoordinator: Coordinatble {
    
    // MARK: - Properties

    private weak var parentCoordinator: CoordinatbleMain?
    
    private var rootViewController: UIViewController
    
    private(set) var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Life cycle

    init(rootVuewController: UIViewController, parentCoordinator: CoordinatbleMain? ) {
        self.rootViewController = rootVuewController
        self.parentCoordinator = parentCoordinator
    }
    
    
    // MARK: - Methods

    func start() {
        let checkerPassword = CheckerPassword()
        let viewModel = LoginViewModel(coordinator: self, checkerPassword: checkerPassword)
        let loginViewController = LoginViewController(viewModel: viewModel)
        let loginNavigation = UINavigationController(rootViewController: loginViewController)
        
        self.rootViewController.children[0].willMove(toParent: nil)
        self.rootViewController.addChild(loginNavigation)
        loginNavigation.view.frame = self.rootViewController.view.bounds
        
        self.rootViewController.transition(
            from: self.rootViewController.children[0],
            to: loginNavigation,
            duration: 0.6,
            options: [.transitionCrossDissolve, .curveEaseOut],
            animations: {},
            completion: {_ in
                self.rootViewController.children[0].removeFromParent()
                loginNavigation.didMove(toParent: self.rootViewController)
            }
        )
    }
    
    func addChildCoordinator(_ coordinator: Coordinatble) {
        guard !self.childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatble) {
        self.childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
}

extension LoginCoordinator: CoordinatbleLogin {
    
    func switchToMainTabBarCoordinator() {
        self.parentCoordinator?.switchToMainTabBar()
    }
}
