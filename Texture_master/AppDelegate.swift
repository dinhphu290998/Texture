//
//  AppDelegate.swift
//  Texture_master
//
//  Created by NDPhu on 9/21/20.
//  Copyright © 2020 ios. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private func initExampleRootView() {
        let loginVC = ICAuthViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initExampleRootView()
        return true
    }

    
}

