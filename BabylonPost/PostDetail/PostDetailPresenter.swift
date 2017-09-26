//
//  PostDetailPresenter.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol PostPresenter {
    
    var view: PostDetailView? { get set }
    var router: PostDetailRouter? { get set }
    var interactor : PostInteractor? { get set }
    var post: Post? { get set }
    var author: User? { get set }
    
    func loadPostData()
    func onSuccessFetchAuthor(user: User)
    func onFailFetchAuthor()
    func onSuccessFetchComment(comments: [Comment])
    func onFailFetchComment()
    func navigateToAuthor()
}

class PostDetailPresenter: PostPresenter {
    
    var view: PostDetailView?
    var router: PostDetailRouter?
    var interactor: PostInteractor?
    var post: Post?
    var author: User?
    
    func loadPostData() {
        if let post = post {
            view?.showPost(post: post)
            interactor?.requestAuthor(userId: post.userId!)
            interactor?.requestComment(postId: post.id!)
        } else {
            view?.onPostNotAvailable()
        }
    }
    
    func onSuccessFetchAuthor(user: User){
        author = user
        view?.setAuthor(user: user)
    }
    
    func onFailFetchAuthor(){
        view?.onAuthorNotAvailable()
    }
    
    func onSuccessFetchComment(comments: [Comment]){
        view?.setComments(comments: comments)
    }
    
    func onFailFetchComment(){
        view?.setNoComment()
    }
    
    func navigateToAuthor() {
        if let view = view {
            if let user = author {
                router?.toAuthorDetail(from: view, author: user)
            }
        } else {
            fatalError("View for post presenter is not set")
        }
    }
}
