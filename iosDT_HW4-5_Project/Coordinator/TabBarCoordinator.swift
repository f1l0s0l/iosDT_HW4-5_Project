//
//  TabBarCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

final class TabBarCoordinator: Coordinatble {
    private weak var parentCoordinator: Coordinatble?
    
    private var rootViewController: UIViewController
    
    
    var childCoordinators: [Coordinatble] = []
    
    
    init(rootViewController: UIViewController, parentCoordinator: Coordinatble) {
        self.rootViewController = rootViewController
        self.parentCoordinator = parentCoordinator
    }
    
    
    func start() {
        let navCont1 = UINavigationController()
        let documentsCoordinator = DocumentsCoordinator(navController: navCont1)
        self.addChildCoordinator(documentsCoordinator)
        documentsCoordinator.start()
        
        let navCont2 = UINavigationController()
        let setupCoordinator = SetupCoordinator(navController: navCont2)
        self.addChildCoordinator(setupCoordinator)
        setupCoordinator.start()
        setupCoordinator.parentCoordinator = self
        
        let tabBarController = MainTabBarController(navControllers: [navCont1, navCont2])

        
        self.rootViewController.addChild(tabBarController)
        tabBarController.view.frame = self.rootViewController.view.bounds
        self.rootViewController.view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self.rootViewController)
        self.rootViewController = tabBarController
    }
    
    func switchToLoginCoordinator() {
        self.childCoordinators.removeAll()
        (self.parentCoordinator as? MainCoordinator)?.switchToLoginCoordinator()
    }
    
    
    func addChildCoordinator(_ coordinator: Coordinatble) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatble) {
        ()
    }
    
    
    
    
}
