//
//  HomeInteractor.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/26/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol HomeInteractorProtocol {
    
    var presenter: HomePresenter? { get set }
    
    func loadPosts()
    func searchPostsByQuery(query: String) -> [Post]
    func getActiveUser() -> String?
    func clearActiveData()
}

class MockHomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenter?
    
    func loadPosts() {
        let posts: [Post] = [
            Post.mockData()
        ]
        presenter?.onSuccessFetchPosts(posts: posts)
    }
    
    func searchPostsByQuery(query: String) -> [Post] {
        return []
    }
    
    func getActiveUser() -> String? {
        return nil
    }
    
    func clearActiveData() {
        print("Active data cleared")
    }
}

class HomeInteractor: HomeInteractorProtocol {
    
    var presenter: HomePresenter?
    
    let apiCaller: APICaller
    let cdManager: CoreDataManager
    let keychainManager: KeychainManager
    
    init(apiCaller: APICaller, coreDataManager: CoreDataManager, keychainManager: KeychainManager) {
        self.apiCaller = apiCaller
        self.cdManager = coreDataManager
        self.keychainManager = keychainManager
    }
    
    func loadPosts() {
        let url = APIConstant.baseUrl + APIConstant.Route.Posts
        apiCaller.getRequest(
            url, headers: nil, parameters: [:],
            onSuccess: { response in
                var postList: [Post] = []
                for obj in response.arrayValue {
                    postList.append(Post.setValueFromJson(obj))
                }
                self.savePostsLocally(postList)
                self.presenter?.onSuccessFetchPosts(posts: postList)
            },
            onFailure: { message in
                self.onTryGetLocalPosts(message)
            }
        )
    }
    
    func searchPostsByQuery(query: String) -> [Post] {
        return cdManager.getPostsByTerm(query)
    }
    
    func getActiveUser() -> String? {
        return keychainManager.getUsername()
    }
    
    func clearActiveData(){
        keychainManager.deleteAllSavedData()
        cdManager.deleteAllPosts()
        cdManager.deleteAllComments()
        cdManager.deleteAllUsers()
        URLCache.shared.removeAllCachedResponses()
    }
    
    private func savePostsLocally(_ posts: [Post]) {
        cdManager.deleteAllPosts()
        cdManager.insertPosts(posts)
    }
    
    private func onTryGetLocalPosts(_ message: String) {
        let localPosts = cdManager.getPosts()
        if localPosts.count > 0 {
            presenter?.onSuccessFetchPosts(posts: localPosts)
        } else {
            presenter?.onFailFetchPosts(message: message)
        }
    }
}
