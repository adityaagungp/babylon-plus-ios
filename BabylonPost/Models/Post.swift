//
//  Post.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/12/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Post {
    
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    static func setValueFromJson(_ json: JSON) -> Post {
        var post = Post()
        post.id = json["id"].int
        post.userId = json["userId"].int
        post.title = json["title"].string
        post.body = json["body"].string
        return post
    }
}

