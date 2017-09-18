//
//  Comment.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comment {
    
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?
    
    static func createFromJson(_ json: JSON) -> Comment {
        var comment = Comment()
        comment.postId = json["postId"].int
        comment.id = json["id"].int
        comment.name = json["name"].string
        comment.email = json["email"].string
        comment.body = json["body"].string
        return comment
    }
}
