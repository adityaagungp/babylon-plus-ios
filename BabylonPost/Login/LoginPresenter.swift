//
//  LoginPresenter.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/26/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    
    var view: LoginViewProtocol? { get set }
    var router: LoginRouter? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    
    func onLogin(username: String)
    func onLoginError()
    func navigateToHome()
}

class LoginPresenter: LoginPresenterProtocol {

    var view: LoginViewProtocol?
    var router: LoginRouter?
    var interactor: LoginInteractorProtocol?
    
    func navigateToHome() {
        router?.navigateToHome()
    }
    
    func onLogin(username: String) {
        interactor?.onLogin(username: username)
    }
    
    func onLoginError() {
        view?.onLoginError(message: "Cannot login")
    }
}
