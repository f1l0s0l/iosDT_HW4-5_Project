//
//  AlertNotification.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import UIKit

final class AlertNotification {
    static let shared = AlertNotification()
    
    func addNewFolderOrFileAlertConfiguration(inViewController vc: UIViewController, title: String?, message: String?, completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addTextField()
        
        let actionOk = UIAlertAction(title: "Ok", style: .default) { alert in
            guard let text = alertController.textFields?[0].text,
                  text != ""
            else {
                return //completion("Новая папка")
            }
            completion(text)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)
        
        vc.present(alertController, animated: true)
    }
    
    
    func addPhotoAlertConfiguration(viewController: UIViewController, completion: @escaping (UIImagePickerController.SourceType?) -> Void) {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let actionCamera = UIAlertAction(title: "Камера", style: .default) { _ in
            completion(.camera)
        }
        
        let actionPhoto = UIAlertAction(title: "Фото/видео", style: .default) { _ in
            completion(.photoLibrary)
        }
        
        let actionCansel = UIAlertAction(title: "Отменить", style: .cancel) { _ in
            completion(nil)
        }
        
        alertController.addAction(actionCamera)
        alertController.addAction(actionPhoto)
        alertController.addAction(actionCansel)
        
        viewController.present(alertController, animated: true)
    }
    
    
    func defaultAlertNotification(text: String, viewController: UIViewController) {
        let alertController = UIAlertController(
            title: text,
            message: nil,
            preferredStyle: .alert
        )
        let actionCansel = UIAlertAction(title: "Отменить", style: .cancel) { _ in}
        alertController.addAction(actionCansel)
        
        viewController.present(alertController, animated: true)
    }
    
}
