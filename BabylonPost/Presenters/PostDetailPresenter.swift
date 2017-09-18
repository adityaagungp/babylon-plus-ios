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
    
    var view: PostDetailView
    
    init(_ view: PostDetailView) {
        self.view = view
    }
    
    func requestAuthor(userId: Int){
        let url = APIConstant.baseUrl + APIConstant.Route.Users
        let parameter = ["id" : userId]
        APICaller.instance.getRequest(
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
        APICaller.instance.getRequest(
            url, headers: nil, parameters: parameter,
            onSuccess: {(response: JSON) -> Void in
                var comments = [Comment]()
                for obj in response.arrayValue {
                    comments.append(Comment.createFromJson(obj))
                }
                self.saveCommentsLocally(comments)
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
        CoreDataManager.instance.insertUser(user)
    }
    
    private func tryFetchLocalUser(_ id: Int){
        let user = CoreDataManager.instance.getUser(id)
        view.setAuthor(user: user)
    }
    
    private func saveCommentsLocally(_ comments: [Comment]){
        CoreDataManager.instance.insertComments(comments)
    }
    
    private func tryFetchLocalComments(_ postId: Int){
        let localComments = CoreDataManager.instance.getComments(postId: postId)
        if localComments.count > 0 {
            onSuccessFetchComment(comments: localComments)
        } else {
            onFailFetchComment()
        }
    }
}
