//
//  User.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/12/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
    
    static func createFromJson(_ json: JSON) -> User {
        var user = User()
        user.id = json["id"].int
        user.name = json["name"].string
        user.username = json["username"].string
        user.email = json["email"].string
        user.address = Address.createFromJson(json["address"])
        user.phone = json["phone"].string
        user.website = json["website"].string
        user.company = Company.createFromJson(json["company"])
        return user
    }
}
