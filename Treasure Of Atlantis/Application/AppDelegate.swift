//
//  AppDelegate.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var gameController: GameViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.gameController = GameViewController()
        let window = UIWindow()
        window.rootViewController = SplashViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        gameController?.saveGameSetup()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        gameController?.loadGameSetup()
    }
}
