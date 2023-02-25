//
//  AlertNotification.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import UIKit

final class AlertNotification {
    static let shared = AlertNotification()
    
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
    
    
    
    
}
