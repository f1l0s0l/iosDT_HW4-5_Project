//
//  SetupViewController.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

final class SetupViewController: UIViewController {
    weak var coordinator: Coordinatble?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
    }
    
    deinit {
        print(#function)
        print("Урра")
    }
    
    
    private func setupView() {
        self.view.backgroundColor = .gray
        self.view.addSubview(testButton)
    }
    
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ttt), for: .touchUpInside)
        button.setTitle("test", for: .normal)
        return button
    }()
    @objc
    private func ttt() {
        (self.coordinator as? SetupCoordinator)?.switchToLoginCoordinator()
    }
    
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.testButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.testButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.testButton.widthAnchor.constraint(equalToConstant: 200),
            self.testButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
