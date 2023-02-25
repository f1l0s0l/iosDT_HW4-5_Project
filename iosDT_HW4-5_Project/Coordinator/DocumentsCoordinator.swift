//
//  DocumentsCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 26.02.2023.
//

import Foundation
import UIKit

final class DocumentsCoordinator: Coordinatble {
    
    private var navigationController: UINavigationController
    
    var childCoordinators: [Coordinatble] = []
    
    
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    
    func start() {
        let documentsViewController = DocumentsViewController()
        self.navigationController.viewControllers = [documentsViewController]
        let tabBarItem = UITabBarItem(
            title: "Documents",
            image: UIImage(systemName: "folder"),
            tag: 0
        )
        self.navigationController.tabBarItem = tabBarItem
        
    }
    
    func addChildCoordinator(_ coordinator: Coordinatble) {
        ()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatble) {
        ()
    }
    
}
