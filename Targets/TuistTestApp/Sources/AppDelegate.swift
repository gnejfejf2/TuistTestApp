//
//  AppDelegate.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appMainCoordinator : AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
//        self.window = window
//        appMainCoordinator = AppCoordinator(window: self.window!)
//        appMainCoordinator?.start()
        
        appMainCoordinator = Assembler.shared.resolver.resolve(AppCoordinator.self, argument: window)
        appMainCoordinator?.start()
        return true
    }
}

