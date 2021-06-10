//
//  AppDelegate.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navController = UINavigationController()
        coordinator = ApplicationCoordinator(navigationController: navController)
        coordinator?.start()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
}

