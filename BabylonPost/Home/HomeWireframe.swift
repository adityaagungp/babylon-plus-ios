//
//  HomeWireframe.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/26/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouter {
    
    func toLoginScreen()
    func toPostDetailScreen(from view: HomeViewProtocol, post: Post, coreDataManager: CoreDataManager)
}

class HomeWireframe: HomeRouter {
    
    class func createHomeModule(keychainManager: KeychainManager, coreDataManager: CoreDataManager) -> MainViewController {
        let mainVC = MainViewController()
        let presenter = PostsPresenter()
        presenter.view = mainVC
        presenter.router = HomeWireframe()
        let interactor = HomeInteractor(apiCaller: APICaller(), coreDataManager: coreDataManager, keychainManager: keychainManager)
        interactor.presenter = presenter
        presenter.interactor = interactor
        mainVC.presenter = presenter
        
        return mainVC
    }
    
    func toLoginScreen() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setLoginAsRootViewController()
    }
    
    func toPostDetailScreen(from view: HomeViewProtocol, post: Post, coreDataManager: CoreDataManager) {
        let postDetailVC = PostDetailWireframe.createPostModule(post: post, apiCaller: APICaller(), coreDataManager: coreDataManager)
        if let sourceVC = view as? UIViewController {
            sourceVC.navigationController?.pushViewController(postDetailVC, animated: true)
        }
    }
}
