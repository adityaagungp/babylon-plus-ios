//
//  UserDetailWireframe.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/26/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation

class UserDetailWireframe {
    
    class func createUserDetailModule(user: User) -> UserDetailViewController {
        let userVC = UserDetailViewController()
        let presenter = UserDetailPresenter()
        presenter.wireframe = UserDetailWireframe()
        presenter.view = userVC
        presenter.user = user
        userVC.presenter = presenter
        
        return userVC
    }
}
