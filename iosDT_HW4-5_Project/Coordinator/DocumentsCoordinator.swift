//
//  DocumentsCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 26.02.2023.
//

import Foundation
import UIKit

protocol CoordinatbleDocuments: AnyObject {
    func openDirectory(directoryPath: String)
    func openFile(filePath: String)
}

final class DocumentsCoordinator: Coordinatble {
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    private(set) var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Life cycle

    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    
    // MARK: - Methods

    func start() {
        let directoryPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let documentsViewController = DocumentsViewController(directoryPath: directoryPath, coordinator: self)
        self.navigationController.viewControllers = [documentsViewController]
        let tabBarItem = UITabBarItem(
            title: "Documents",
            image: UIImage(systemName: "folder"),
            tag: 0
        )
        self.navigationController.tabBarItem = tabBarItem
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


extension DocumentsCoordinator: CoordinatbleDocuments {
    
    func openDirectory(directoryPath: String) {
        let internalDocumentsViewController = DocumentsViewController(directoryPath: directoryPath, coordinator: self)
        self.navigationController.pushViewController(internalDocumentsViewController, animated: true)
    }
    
    func openFile(filePath: String) {
        let fileVC = FileViewController(filePath: filePath)
        self.navigationController.pushViewController(fileVC, animated: true)
    }
    
}
