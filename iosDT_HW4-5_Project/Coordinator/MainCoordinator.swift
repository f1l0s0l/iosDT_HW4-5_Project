//
//  MainCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinatble {
    private weak var rootViewController: UIViewController?
   
    
    var childCoordinators: [Coordinatble] = []
    
    
    
    
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    
    
    
    func start() {
        self.switchToLoginCoordinator()
    }
    
    func switchToMainTabBarCoordinator() {
        self.removeChildCoordinator(childCoordinators[0])
        print("Это в mainCoordinator")
        let mainTabBarCoordinator = TabBarCoordinator(rootViewController: self.rootViewController, parentCoordinator: self)
        self.addChildCoordinator(mainTabBarCoordinator)
        mainTabBarCoordinator.start()
//        mainTabBarCoordinator.parentCoordinator = self
    }
    
    func switchToLoginCoordinator() {
        if childCoordinators.count > 0 {
            self.removeChildCoordinator(childCoordinators[0])
        }
//        self.removeChildCoordinator(childCoordinators[0])
        let loginCoordinator = LoginCoordinator(rootVuewController: self.rootViewController, parentCoordinator: self)
        self.addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
//        loginCoordinator.parentCoordinator = self
    }
    
    
    func addChildCoordinator(_ coordinator: Coordinatble) {
        childCoordinators.append(coordinator)
        print("теперь в списке")
        print(childCoordinators.count)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatble) {
        self.childCoordinators.removeAll(where: {$0 === coordinator})
        print("Удалили")
        print(childCoordinators.count)

    }
    
    
}
