//
//  MainTabBarController.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
//    private var navControllers: [UIViewController] = []
    
    
    init(navControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = navControllers
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func configurationNavController() {
        
    }
    
    private func setupView() {
        UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = .white

        UINavigationBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        UINavigationBar.appearance().backgroundColor = .white
    }
    
    
}
