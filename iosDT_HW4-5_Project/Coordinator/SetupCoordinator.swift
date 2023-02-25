//
//  SetupCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 26.02.2023.
//

import Foundation
import UIKit

final class SetupCoordinator: Coordinatble {
    
    weak var parentCoordinator: Coordinatble?
    
    private var navigationController: UINavigationController
    
    var childCoordinators: [Coordinatble] = []
    
    
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let setupViewController = SetupViewController()
        setupViewController.coordinator = self
        self.navigationController.viewControllers = [setupViewController]
        let tabBarItem = UITabBarItem(
            title: "Setup",
            image: UIImage(systemName: "gearshape"),
            tag: 1
        )
        self.navigationController.tabBarItem = tabBarItem
        
    }
    
    func switchToLoginCoordinator() {
        (self.parentCoordinator as? TabBarCoordinator)?.switchToLoginCoordinator()
    }
    
    func addChildCoordinator(_ coordinator: Coordinatble) {
        ()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatble) {
        ()
    }
    
    
}
