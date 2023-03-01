//
//  SetupCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 26.02.2023.
//

import Foundation
import UIKit

protocol CoordinatbleSetup: AnyObject {
    func switchToLoginCoordinator() 
}

final class SetupCoordinator: Coordinatble {
    
    // MARK: - Properties

    private weak var parentCoordinator: CoordinatbleTabBarCoordinator?
    
    private var navigationController: UINavigationController
    
    var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Life cycle
    
    init(navController: UINavigationController, parentCoordinator: CoordinatbleTabBarCoordinator?) {
        self.navigationController = navController
        self.parentCoordinator = parentCoordinator
    }
    
    
    // MARK: - Methods
    
    func start() {
        let setupViewController = SetupViewController(coordinator: self)
        self.navigationController.viewControllers = [setupViewController]
        let tabBarItem = UITabBarItem(
            title: "Setup",
            image: UIImage(systemName: "gearshape"),
            tag: 1
        )
        self.navigationController.tabBarItem = tabBarItem
    }
    
//    func switchToLoginCoordinator() {
//        (self.parentCoordinator as? TabBarCoordinator)?.switchToLoginCoordinator()
//    }
    
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

extension SetupCoordinator: CoordinatbleSetup {
    func switchToLoginCoordinator() {
        self.parentCoordinator?.switchToLoginCoordinator()
    }
}
