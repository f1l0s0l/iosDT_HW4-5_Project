//
//  LoginViewModel.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 26.02.2023.
//

import Foundation

final class LoginViewModel {
    
    // MARK: - Enum
    
    enum State {
        case initial
        case havePassword
        case noHavePassword
        case repeatPassword
        case hideKeyboard
        case wrong(text: String)
        case error
    }
    
    enum Action {
        case didTapLoginButton(pswrd: String?)
        case didTapSuperView
    }
    
    
    // MARK: - Public properties
    
    var stateChenged: ((State) -> Void)?
    private(set) var state: State = .initial {
        didSet {
            stateChenged?(state)
        }
    }
    
    // MARK: - Properties
    
    private var checkerPassword: CheckerPassword
    
    private weak var coordinator: CoordinatbleLogin?
    
    // MARK: - Life cycle
    
    init(coordinator: CoordinatbleLogin?, checkerPassword: CheckerPassword) {
        self.coordinator = coordinator
        self.checkerPassword = checkerPassword
    }
    
    deinit {
        print("LoginViewModel \(#function)")
    }
    
    
    // MARK: - Public methods
    
    func didTap(action: Action) {
        self.state = .hideKeyboard
        
        switch action {
        case .didTapLoginButton(let pswrd):
            self.checkerPassword.checkPassword(pswrd: pswrd) { [weak self] state in
                switch state {
                    
                case .success:
                    self?.coordinator?.switchToMainTabBarCoordinator()
                    
                case .repeatPswrd:
                    self?.state = .repeatPassword
                    
                case .wrongRepeatPswrd(let error):
                    self?.state = .noHavePassword
                    self?.state = .wrong(text: error.description)
                    
                case .error(let error):
                    self?.state = .wrong(text: error.description)
                }
            }
            
        case .didTapSuperView:
            ()
//            self.state = .hideKeyboard
        }
    }
    
    func initConfirugation() {
        if checkerPassword.isHavePassword {
            self.state = .havePassword
        } else {
            self.state = .noHavePassword
        }
    }
    
}
