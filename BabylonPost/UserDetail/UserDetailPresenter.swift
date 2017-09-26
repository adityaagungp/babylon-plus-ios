//
//  UserDetailPresenter.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/26/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation

protocol UserPresenter {
    
    var view: UserDetailView? { get set }
    var wireframe: UserDetailWireframe? { get set }
    var user: User? { get set }
    
    func showUser()
}

class UserDetailPresenter: UserPresenter {
    
    var view: UserDetailView?
    var wireframe: UserDetailWireframe?
    var user: User?
    
    func showUser(){
        view?.showUserData(user: user)
    }
}
