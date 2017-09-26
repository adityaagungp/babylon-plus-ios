//
//  LoginWireframe.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/26/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import UIKit

protocol LoginRouter {
    
    func navigateToHome()
}

class LoginWireframe: LoginRouter {
    
    class func createLoginModule(keychainManager: KeychainManager) -> LoginViewController {
        let loginVC = LoginViewController()
        let loginPresenter = LoginPresenter()
        loginPresenter.view = loginVC
        loginPresenter.router = LoginWireframe()
        let loginInteractor = LoginInteractor(keyChainManager: keychainManager)
        loginInteractor.presenter = loginPresenter
        loginPresenter.interactor = loginInteractor
        loginVC.presenter = loginPresenter
        
        return loginVC
    }
    
    func navigateToHome() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setHomeAsRootViewController()
    }
}
