//
//  PostDetailWireframe.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/26/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import UIKit

protocol PostDetailRouter {
    
    func toAuthorDetail(from view: PostDetailView, author: User)
}

class PostDetailWireframe: PostDetailRouter {
    
    class func createPostModule(post: Post, apiCaller: APICaller, coreDataManager: CoreDataManager) -> PostDetailViewController {
        let postVC = PostDetailViewController()
        
        let presenter = PostDetailPresenter()
        presenter.view = postVC
        presenter.router = PostDetailWireframe()
        presenter.post = post
        
        let interactor = PostDetailInteractor(apiCaller: apiCaller, coreDataManager: coreDataManager)
        interactor.presenter = presenter
        presenter.interactor = interactor
        postVC.presenter = presenter
        
        return postVC
    }
    
    func toAuthorDetail(from view: PostDetailView, author: User) {
        let userVC = UserDetailWireframe.createUserDetailModule(user: author)
        if let sourceVC = view as? UIViewController {
            sourceVC.navigationController?.pushViewController(userVC, animated: true)
        }
    }
}
