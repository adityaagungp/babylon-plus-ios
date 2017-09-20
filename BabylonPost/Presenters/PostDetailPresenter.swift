//
//  PostDetailPresenter.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

class PostDetailPresenter {
    
    let view: PostDetailView
    let apiCaller: APICaller
    let cdManager: CoreDataManager
    
    init(_ view: PostDetailView, apiCaller: APICaller, coreDataManager: CoreDataManager) {
        self.view = view
        self.apiCaller = apiCaller
        self.cdManager = coreDataManager
    }
    
    func requestAuthor(userId: Int){
        let url = APIConstant.baseUrl + APIConstant.Route.Users
        let parameter = ["id" : userId]
        apiCaller.getRequest(
            url, headers: nil, parameters: parameter,
            onSuccess: {(response: JSON) -> Void in
                let user = User.createFromJson(response.arrayValue[0])
                self.saveUserLocally(user)
                self.onSuccessFetchAuthor(user: user)
        },
            onFailure: {(message: String) -> Void in
                self.tryFetchLocalUser(userId)
        })
    }
    
    func requestComment(postId: Int){
        let url = APIConstant.baseUrl +  APIConstant.Route.Comments
        let parameter = ["postId" : postId]
        apiCaller.getRequest(
            url, headers: nil, parameters: parameter,
            onSuccess: {(response: JSON) -> Void in
                var comments = [Comment]()
                for obj in response.arrayValue {
                    comments.append(Comment.createFromJson(obj))
                }
                self.saveCommentsLocally(postId, comments)
                self.onSuccessFetchComment(comments: comments)
        },
            onFailure: {(message: String) -> Void in
                self.tryFetchLocalComments(postId)
        })
    }
    
    func onSuccessFetchAuthor(user: User){
        view.setAuthor(user: user)
    }
    
    func onFailFetchAuthor(){
        view.setAuthor(user: nil)
    }
    
    func onSuccessFetchComment(comments: [Comment]){
        view.setComments(comments: comments)
    }
    
    func onFailFetchComment(){
        view.setNoComment()
    }
    
    private func saveUserLocally(_ user: User){
        cdManager.insertOrUpdateUser(user)
    }
    
    private func tryFetchLocalUser(_ id: Int){
        let user = cdManager.getUser(id)
        view.setAuthor(user: user)
    }
    
    private func saveCommentsLocally(_ postId: Int, _ comments: [Comment]){
        cdManager.deleteCommentsOfPost(postId: postId)
        cdManager.insertComments(comments)
    }
    
    private func tryFetchLocalComments(_ postId: Int){
        let localComments = cdManager.getComments(postId: postId)
        if localComments.count > 0 {
            onSuccessFetchComment(comments: localComments)
        } else {
            onFailFetchComment()
        }
    }
}
