//
//  AppDelegate.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/12/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        var launchVC: UIViewController
        if KeychainManager.instance.getUsername() == nil{
            launchVC = LoginViewController()
        } else {
            launchVC = UINavigationController(rootViewController: MainViewController())
        }
        setRootViewController(launchVC)
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataStack.instance.saveContext()
    }
    
    func setRootViewController(_ vc: UIViewController){
        window!.rootViewController?.dismiss(animated: false, completion: nil)
        window!.rootViewController = vc
    }
}

