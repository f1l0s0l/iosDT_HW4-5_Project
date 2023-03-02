//
//  LoginViewController.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: LoginViewModel
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 6.25
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc
    private func didTapLoginButton() {
        self.viewModel.didTap(action: .didTapLoginButton(pswrd: self.passwordTextField.text))
    }
    
    
    // MARK: - Life cycle
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.bindViewModel()
        self.viewModel.initConfirugation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("LoginViewController \(#function)")
    }
    
    
    // MARK: - Bind viewModel
    
    private func bindViewModel() {
        viewModel.stateChenged = { [weak self] state in
            guard let self = self else {return}
            
            switch state {
            case .initial:
                print("initial")
                
            case .havePassword:
                self.loginButton.setTitle("Введите пароль", for: .normal)
                self.passwordTextField.text = ""
                
            case .noHavePassword:
                self.loginButton.setTitle("Создайте пароль", for: .normal)
                self.passwordTextField.text = ""
                
            case .repeatPassword:
                self.loginButton.setTitle("Повторите пароль", for: .normal)
                self.passwordTextField.text = ""
                
            case .hideKeyboard:
                self.view.endEditing(true)
                
            case .wrong(let text):
                AlertNotification.shared.defaultAlertNotification(text: text, viewController: self)
                
            case .error:
                AlertNotification.shared.defaultAlertNotification(text: "Неизвестная ошибка", viewController: self)
                print("Неизвестная ошибка !!!!")
            }
            
        }
    }
    
    
    // MARK: - Methods

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.passwordTextField)
        self.stackView.addArrangedSubview(self.loginButton)
        self.setupGestureRecognizer()
    }
    
    private func setupGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSuperView))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    private func didTapSuperView() {
        self.viewModel.didTap(action: .didTapSuperView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            self.loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
