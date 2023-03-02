//
//  MainCoordinator.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

protocol CoordinatbleMain: AnyObject {
    func switchToMainTabBar()
    func switchToLogin()
}

final class MainCoordinator: Coordinatble {
    
    // MARK: - Properties
    
    private var rootViewController: UIViewController
   
    private(set) var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Life cycle
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    
    // MARK: - Methods
    
    func start() {
        let loadingViewController = LoadingViewController()
        self.rootViewController.addChild(loadingViewController)
        loadingViewController.view.frame = self.rootViewController.view.bounds
        self.rootViewController.view.addSubview(loadingViewController.view)
        loadingViewController.didMove(toParent: self.rootViewController)
        
//        тут какая ни будь проверка, запросы в сеть и так далее
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(0)) {
            self.switchToLoginCoordinator()
        }
//        self.switchToLoginCoordinator()
    }
    
    func switchToMainTabBarCoordinator() {
        self.removeChildCoordinator(childCoordinators[0])
        let tabBarCoordinator = TabBarCoordinator(rootViewController: self.rootViewController, parentCoordinator: self)
        self.addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
    func switchToLoginCoordinator() {
        if childCoordinators.count > 0 {
            self.removeChildCoordinator(childCoordinators[0])
        }
        let loginCoordinator = LoginCoordinator(rootVuewController: self.rootViewController, parentCoordinator: self)
        self.addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
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

extension MainCoordinator: CoordinatbleMain {
    func switchToMainTabBar() {
        self.switchToMainTabBarCoordinator()
    }
    
    func switchToLogin(){
        self.switchToLoginCoordinator()
    }
}
