//
//  CoreDataKey.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/17/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation

enum CoreDataKey {
    
    enum Entity {
        static let Post = "CDPost"
        static let User = "CDUser"
        static let Address = "CDAddress"
        static let Geo = "CDGeo"
        static let Company = "CDCompany"
        static let Comment = "CDComment"
    }
    
    enum Post {
        static let UserId = "userId"
        static let Id = "id"
        static let Title = "title"
        static let Body = "body"
    }
    
    enum User {
        static let Id = "id"
        static let Name = "name"
        static let Username = "username"
        static let Email = "email"
        static let Address = "address"
        static let Phone = "phone"
        static let Website = "website"
        static let Company = "company"
    }
    
    enum Address {
        static let Street = "street"
        static let Suite = "suite"
        static let City = "city"
        static let Zipcode = "zipcode"
        static let Geo = "geo"
    }
    
    enum Geo {
        static let Lat = "lat"
        static let Lng = "lng"
    }
    
    enum Company {
        static let Name = "name"
        static let CatchPhrase = "catchPhrase"
        static let Bs = "bs"
    }
    
    enum Comment {
        static let PostId = "postId"
        static let Id = "id"
        static let Name = "name"
        static let Email = "email"
        static let Body = "body"
    }
}
