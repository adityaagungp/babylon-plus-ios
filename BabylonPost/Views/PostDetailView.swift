//
//  PostDetailView.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation

protocol PostDetailView {
    
    func setAuthor(user: User?)
    func setComments(comments: [Comment])
    func setNoComment()
}
