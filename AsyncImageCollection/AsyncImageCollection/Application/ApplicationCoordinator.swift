//
//  ApplicationCoordinator.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = PopularMoviesViewController(movieRepository: MovieNetworkRepository())
        navigationController.pushViewController(vc, animated: false)
    }
}
