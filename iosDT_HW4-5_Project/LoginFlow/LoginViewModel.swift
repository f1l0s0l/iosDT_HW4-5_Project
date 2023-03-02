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
    
    weak var coordinatorDismissDelegate: CoordinatorDismissDelegate?
    
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
        print("loginViewModel \(#function)")
    }
    
    
    // MARK: - Public methods
    
    func didTap(action: Action) {
        self.state = .hideKeyboard
        
        switch action {
        case .didTapLoginButton(let pswrd):
            
            let isUpdatePswrd: Bool = (self.coordinator == nil) ? true : false
            
            self.checkerPassword.checkPassword(pswrd: pswrd, isUpatePswrd: isUpdatePswrd) { [weak self] state in
                switch state {

                case .success:
                    if isUpdatePswrd {
                        self?.coordinatorDismissDelegate?.dismiss()
                    } else {
                        self?.coordinator?.switchToMainTabBarCoordinator()
                    }

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
        guard self.coordinator == nil else {
            
            if self.checkerPassword.isHavePassword {
                self.state = .havePassword
            } else {
                self.state = .noHavePassword
            }

            return
        }
        
        self.state = .noHavePassword
    }
        
}
