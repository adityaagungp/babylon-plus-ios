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
    var keychainManager: KeychainManager = KeychainManager()
    var coreDataManager: CoreDataManager = CoreDataManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        coreDataManager.coreDataStack = CoreDataStack()
        if keychainManager.getUsername() == nil {
            setLoginAsRootViewController()
        } else {
            setHomeAsRootViewController()
        }
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        coreDataManager.saveContext()
    }
    
    func setRootViewController(_ vc: UIViewController){
        window!.rootViewController?.dismiss(animated: false, completion: nil)
        window!.rootViewController = vc
    }
    
    func setLoginAsRootViewController(){
        let loginVC = LoginViewController()
        loginVC.keychainManager = keychainManager
        setRootViewController(loginVC)
    }
    
    func setHomeAsRootViewController(){
        let mainVC = MainViewController()
        mainVC.keychainManager = keychainManager
        mainVC.coreDataManager = coreDataManager
        setRootViewController(UINavigationController(rootViewController: mainVC))
    }
}
