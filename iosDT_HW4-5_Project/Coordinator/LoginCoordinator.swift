//
//  LoginCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

final class LoginCoordinator: Coordinatble {
    private weak var parentCoordinator: Coordinatble?
    
    private var rootViewController: UIViewController
    
    var childCoordinators: [Coordinatble] = []
    
    
    init(rootVuewController: UIViewController, parentCoordinator: Coordinatble ) {
        self.rootViewController = rootVuewController
        self.parentCoordinator = parentCoordinator
    }
    
    
    func start() {
//        self.rootViewController.willMove(toParent: nil)
//        self.rootViewController.view.removeFromSuperview()
//        self.rootViewController.removeFromParent()
        
        let loginViewController = LoginViewController()
        let new = UINavigationController(rootViewController: loginViewController)
        self.rootViewController.addChild(new)
        new.view.frame = self.rootViewController.view.bounds
        self.rootViewController.view.addSubview(new.view)
        new.didMove(toParent: self.rootViewController)
        self.rootViewController = new
        loginViewController.coordinator = self
    }
    
    func switchToMainTabBarCoordinator() {
        (self.parentCoordinator as? MainCoordinator)?.switchToMainTabBarCoordinator()
    }
    
    
    func addChildCoordinator(_ coordinator: Coordinatble) {
        ()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatble) {
        ()
    }
    
    
}
