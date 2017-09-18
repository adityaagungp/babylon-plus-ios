//
//  PostsView.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation

protocol PostsView {
    
    func setPosts(posts: [Post])
    func showNoPost()
}
