//
//  LoginInteractor.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/26/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation

protocol LoginInteractorProtocol {
    
    var presenter: LoginPresenterProtocol? { get set }
    
    func onLogin(username: String)
}

class LoginInteractor: LoginInteractorProtocol {
    
    var presenter: LoginPresenterProtocol?
    let keyChainManager: KeychainManager
    
    init(keyChainManager: KeychainManager) {
        self.keyChainManager = keyChainManager
    }
    
    func onLogin(username: String) {
        keyChainManager.setUsername(username)
        presenter?.navigateToHome()
    }
}
