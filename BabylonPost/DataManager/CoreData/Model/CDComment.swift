//
//  CDComment+CoreDataClass.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

@objc(CDComment)
public class CDComment: NSManagedObject {
    
    @NSManaged public var body: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var postId: Int64
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDComment> {
        return NSFetchRequest<CDComment>(entityName: CoreDataKey.Entity.Comment)
    }
    
    func setCommentValues(_ comment: Comment){
        setValue(comment.id, forKey: CoreDataKey.Comment.Id)
        setValue(comment.postId, forKey: CoreDataKey.Comment.PostId)
        setValue(comment.name, forKey: CoreDataKey.Comment.Name)
        setValue(comment.email, forKey: CoreDataKey.Comment.Email)
        setValue(comment.body, forKey: CoreDataKey.Comment.Body)
    }
    
    func commentFromValues() -> Comment {
        var comment = Comment()
        comment.id = value(forKey: CoreDataKey.Comment.Id) as? Int
        comment.postId = value(forKey: CoreDataKey.Comment.PostId) as? Int
        comment.name = value(forKey: CoreDataKey.Comment.Name) as? String
        comment.email = value(forKey: CoreDataKey.Comment.Email) as? String
        comment.body = value(forKey: CoreDataKey.Comment.Body) as? String
        return comment
    }
}
