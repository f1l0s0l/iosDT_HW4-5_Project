//
//  LoginViewController.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    weak var coordinator: Coordinatble?
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Test", for: .normal)
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        return button
    }()
    @objc
    private func test() {
        (self.coordinator as? LoginCoordinator)?.switchToMainTabBarCoordinator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
        print(#function)
    }
    
    deinit {
        print(#function)
    }
    
    
    private func setupView() {
        self.view.backgroundColor = .brown
        self.view.addSubview(self.nextButton)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.nextButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.nextButton.widthAnchor.constraint(equalToConstant: 200),
            self.nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
