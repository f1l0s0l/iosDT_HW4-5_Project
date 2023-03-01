//
//  LoadingViewController.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 26.02.2023.
//

import Foundation
import UIKit

final class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("Удалился загрузочный экран")
    }
    
}
