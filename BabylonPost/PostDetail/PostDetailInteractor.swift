//
//  PostDetailInteractor.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/26/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol PostInteractor {
    
    var presenter: PostPresenter? { get set }
    
    func requestAuthor(userId: Int)
    func requestComment(postId: Int)
}

class PostDetailInteractor: PostInteractor {
    
    var presenter: PostPresenter?
    
    private let apiCaller: APICaller
    private let cdManager: CoreDataManager
    
    init(apiCaller: APICaller, coreDataManager: CoreDataManager) {
        self.apiCaller = apiCaller
        self.cdManager = coreDataManager
    }
    
    func requestAuthor(userId: Int) {
        let url = APIConstant.baseUrl + APIConstant.Route.Users
        let parameter = ["id" : userId]
        apiCaller.getRequest(
            url, headers: nil,
            parameters: parameter,
            onSuccess: { (response: JSON) -> Void in
                guard let userResponse = response.arrayValue.first else { return }
                let user = User.createFromJson(userResponse)
                self.saveUserLocally(user)
                self.presenter?.onSuccessFetchAuthor(user: user)
            },
            onFailure: { (message: String) -> Void in
                self.tryFetchLocalUser(userId)
            }
        )
    }
    
    func requestComment(postId: Int) {
        let url = APIConstant.baseUrl +  APIConstant.Route.Comments
        let parameter = ["postId" : postId]
        apiCaller.getRequest(
            url, headers: nil, parameters: parameter,
            onSuccess: { response in
                var comments: [Comment] = []
                for obj in response.arrayValue {
                    comments.append(Comment.createFromJson(obj))
                }
                self.saveCommentsLocally(postId, comments)
                self.presenter?.onSuccessFetchComment(comments: comments)
            },
            onFailure: { message in
                self.tryFetchLocalComments(postId)
            }
        )
    }
    
    private func saveUserLocally(_ user: User) {
        cdManager.insertOrUpdateUser(user)
    }
    
    private func tryFetchLocalUser(_ id: Int) {
        let user = cdManager.getUser(id)
        if let user = user {
            presenter?.onSuccessFetchAuthor(user: user)
        } else {
            presenter?.onFailFetchAuthor()
        }
    }
    
    private func saveCommentsLocally(_ postId: Int, _ comments: [Comment]) {
        cdManager.deleteCommentsOfPost(postId: postId)
        cdManager.insertComments(comments)
    }
    
    private func tryFetchLocalComments(_ postId: Int) {
        let localComments = cdManager.getComments(postId: postId)
        if localComments.count > 0 {
            presenter?.onSuccessFetchComment(comments: localComments)
        } else {
            presenter?.onFailFetchComment()
        }
    }
}
