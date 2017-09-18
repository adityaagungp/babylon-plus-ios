//
//  PostsPresenter.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

class PostsPresenter {
    
    var view: PostsView
    
    init(_ view: PostsView) {
        self.view = view
    }
    
    func loadPosts() {
        let url = APIConstant.baseUrl + APIConstant.Route.Posts
        APICaller.instance.getRequest(
            url, headers: nil, parameters: [:],
            onSuccess: {(response: JSON) -> Void in
                var postList = [Post]()
                for obj in response.arrayValue {
                    postList.append(Post.setValueFromJson(obj))
                }
                self.savePostsLocally(postList)
                self.onSuccessFetchPosts(posts: postList)
            },
            onFailure: {(message: String) -> Void in
                self.onTryGetLocalPosts(message)
        })

    }
    
    func onSuccessFetchPosts(posts: [Post]){
        view.setPosts(posts: posts)
    }
    
    func onFailFetchPosts(message: String){
        view.showNoPost()
    }
    
    private func savePostsLocally(_ posts: [Post]){
        CoreDataManager.instance.insertPosts(posts)
    }
    
    private func onTryGetLocalPosts(_ message: String){
        let localPosts = CoreDataManager.instance.getPosts()
        if localPosts.count > 0 {
            onSuccessFetchPosts(posts: localPosts)
        } else {
            onFailFetchPosts(message: message)
        }
    }
}
