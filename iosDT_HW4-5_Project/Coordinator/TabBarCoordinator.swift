//
//  TabBarCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

protocol CoordinatbleTabBarCoordinator: AnyObject {
    func switchToLoginCoordinator()
}

final class TabBarCoordinator: Coordinatble {
    
    // MARK: - Properties

    private weak var parentCoordinator: CoordinatbleMain?
    
    private var rootViewController: UIViewController
    
    private(set) var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Life cycle

    init(rootViewController: UIViewController, parentCoordinator: CoordinatbleMain?) {
        self.rootViewController = rootViewController
        self.parentCoordinator = parentCoordinator
    }
    
    
    // MARK: - Methods

    func start() {
        // По хорошему сделать Factory по созданию Flow
        // Но это актуально при работе с MVVM (я так понимаю)
        // когда в Factory инжектяться все зависимости (viewModel и Model)
        // Ну и в этом тестовом варианте это было бы уже очень круто) и так намаялся с переходами между Flow
        
        // Создаем flow Docunets
        let navCont1 = UINavigationController()
        let documentsCoordinator = DocumentsCoordinator(navController: navCont1)
        self.addChildCoordinator(documentsCoordinator)
        documentsCoordinator.start()
        
        // Создаем flow setup
        let navCont2 = UINavigationController()
        let setupCoordinator = SetupCoordinator(navController: navCont2, parentCoordinator: self)
        self.addChildCoordinator(setupCoordinator)
        setupCoordinator.start()        
        
        let tabBarController = TabBarController(navControllers: [navCont1, navCont2])
        self.rootViewController.children[0].willMove(toParent: nil)
        self.rootViewController.addChild(tabBarController)
        tabBarController.view.frame = self.rootViewController.view.bounds
        
        self.rootViewController.transition(
            from: self.rootViewController.children[0],
            to: tabBarController,
            duration: 0.6,
            options: [.transitionCrossDissolve, .curveEaseOut],
            animations: {},
            completion: {_ in
                self.rootViewController.children[0].removeFromParent()
                tabBarController.didMove(toParent: self.rootViewController)
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

extension TabBarCoordinator: CoordinatbleTabBarCoordinator {
    func switchToLoginCoordinator() {
        self.parentCoordinator?.switchToLogin()
        self.childCoordinators.removeAll()
    }
}
