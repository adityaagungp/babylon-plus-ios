//
//  PostsPresenter.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol HomePresenter {
    
    var view: HomeViewProtocol? { get set }
    var router: HomeRouter? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    
    func onSetHomeTitle()
    func loadPosts()
    func onSuccessFetchPosts(posts: [Post])
    func onFailFetchPosts(message: String)
    func searchPost(query: String)
    func navigateToPost(post: Post)
    func onLogout()
}

class PostsPresenter: HomePresenter {
    
    var view: HomeViewProtocol?
    var router: HomeRouter?
    var interactor: HomeInteractorProtocol?
    
    func onSetHomeTitle() {
        let user = interactor?.getActiveUser()
        view?.setHomeTitle(forUsername: user)
    }
    
    func loadPosts() {
        interactor?.loadPosts()
    }
    
    func onSuccessFetchPosts(posts: [Post]) {
        view?.setPosts(posts: posts)
    }
    
    func onFailFetchPosts(message: String) {
        view?.showNoPost()
    }
    
    func searchPost(query: String) {
        guard let interactor = interactor else { return }
        view?.setSearchResult(result: interactor.searchPostsByQuery(query: query))
    }
    
    func navigateToPost(post: Post) {
        if let view = view {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            router?.toPostDetailScreen(from: view, post: post, coreDataManager: appDelegate.coreDataManager)
        } else {
            fatalError("View for home presenter is not set")
        }
    }
    
    func onLogout() {
        interactor?.clearActiveData()
        router?.toLoginScreen()
    }
}
