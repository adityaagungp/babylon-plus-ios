//
//  CDPost+CoreDataClass.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

@objc(CDPost)
public class CDPost: NSManagedObject {

    @NSManaged public var body: String?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var userId: Int64
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPost> {
        return NSFetchRequest<CDPost>(entityName: CoreDataKey.Entity.Post)
    }
    
    func setPostValues(_ post: Post){
        setValue(post.id, forKey: CoreDataKey.Post.Id)
        setValue(post.userId, forKey: CoreDataKey.Post.UserId)
        setValue(post.title, forKey: CoreDataKey.Post.Title)
        setValue(post.body, forKey: CoreDataKey.Post.Body)
    }
    
    func postFromValues() -> Post {
        var post = Post()
        post.id = value(forKey: CoreDataKey.Post.Id) as? Int
        post.userId = value(forKey: CoreDataKey.Post.UserId) as? Int
        post.title = value(forKey: CoreDataKey.Post.Title) as? String
        post.body = value(forKey: CoreDataKey.Post.Body) as? String
        return post
    }
}
