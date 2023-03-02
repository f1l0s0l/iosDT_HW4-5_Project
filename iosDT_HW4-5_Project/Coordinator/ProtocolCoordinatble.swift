//
//  ProtocolCoordinatble.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

protocol Coordinatble: AnyObject {
    var childCoordinators: [Coordinatble] { get }
    func start()// -> UIViewController
    func addChildCoordinator(_ coordinator: Coordinatble)
    func removeChildCoordinator(_ coordinator: Coordinatble)
}
