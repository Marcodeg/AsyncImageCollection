//
//  Coordinator.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
