//
//  CheckerPassword.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 26.02.2023.
//

import Foundation
import KeychainAccess

enum StateCheckerPassword {
    case success
    case repeatPswrd
    case wrongRepeatPswrd(error: CheckerError = .wrongRepeatPswrd)
    case error(error: CheckerError)
}

enum CheckerError: Error {
    case weakPswrd
    case wrongPswrd
    case wrongRepeatPswrd
    case unknowError
    
    var description: String {
        switch self {
        case .weakPswrd:
            return "Пароль меньше 4 символов"
        case .wrongPswrd:
            return "Неправильный пароль"
        case .wrongRepeatPswrd:
            return "Пароли не совпадают"
        case .unknowError:
            return "Неизвестная ошибка"
    
        }
    }
    
}

final class CheckerPassword {
    
    // MARK: - Public properties
    
    var isHavePassword: Bool {
        do {
            guard let _ = try keychain.get("password") else {
                return false
            }
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    
    // MARK: - Properties
    
    private let keychain = Keychain(service: "MyPassword")

    private var tempPswrd: String?
    
    
    // MARK: - Public methods
    
    func removePassword() {
        do {
            try keychain.remove("password")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func checkPassword(pswrd: String?, isUpatePswrd: Bool = false, completion: @escaping (StateCheckerPassword) -> Void) {
        guard pswrd?.count ?? 0 > 4 else {
            return completion(.error(error: .weakPswrd))
        }
        
        guard !isUpatePswrd else {
            self.checkNewPassword(pswrd: pswrd, completion: completion)
            return
        }
        
        if isHavePassword {
            self.checkMyPassword(pswrd: pswrd, completion: completion)
        } else {
            self.checkNewPassword(pswrd: pswrd, completion: completion)
        }
        
    }
    
    
    // MARK: - Methods
    
    private func checkMyPassword(pswrd: String?, completion: @escaping (StateCheckerPassword) -> Void) {
        let myPassword = try? keychain.get("password")
        
        if pswrd == myPassword {
            completion(.success)
        } else {
            completion(.error(error: .wrongPswrd))
        }
    }
    
    private func checkNewPassword(pswrd: String?, completion: @escaping (StateCheckerPassword) -> Void) {
        guard self.tempPswrd == nil else {
            self.repeatPassword(pswrd: pswrd, completion: completion)
            return
        }
        self.tempPswrd = pswrd
        completion(.repeatPswrd)
    }
    
    private func repeatPassword(pswrd: String?, completion: @escaping (StateCheckerPassword) -> Void) {
        
        guard pswrd != tempPswrd else {
            self.createNewPassword(pswrd: pswrd!, completion: completion)
            return
        }
        
        self.tempPswrd = nil
        completion(.wrongRepeatPswrd())
    }
    
    private func createNewPassword(pswrd: String, completion: @escaping (StateCheckerPassword) -> Void) {
        do {
            try keychain.set(pswrd, key: "password")
            completion(.success)
        } catch {
            print(error.localizedDescription)
            completion(.error(error: .unknowError))
        }
    }
    
}
