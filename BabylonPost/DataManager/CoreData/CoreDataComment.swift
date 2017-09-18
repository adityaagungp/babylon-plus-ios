//
//  CoreDataComment.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    //MARK: - Create
    
    func insertComment(_ comment: Comment){
        let commentCD = NSEntityDescription.insertNewObject(forEntityName: CoreDataKey.Entity.Comment, into: CoreDataStack.context) as! CDComment
        commentCD.setCommentValues(comment)
        CoreDataStack.instance.saveContext()
    }
    
    func insertComments(_ comments: [Comment]){
        for comment in comments {
            let request: NSFetchRequest<CDComment> = CDComment.fetchRequest()
            request.predicate = NSPredicate(format: "id = %@", NSNumber(value: comment.id!))
            let context = CoreDataStack.context
            do {
                let fetchResult = try context.fetch(request)
                if fetchResult.count > 0 {
                    let updatedComment = fetchResult[0]
                    updatedComment.setCommentValues(comment)
                } else {
                    let commentCD = NSEntityDescription.insertNewObject(forEntityName: CoreDataKey.Entity.Comment, into: context) as! CDComment
                    commentCD.setCommentValues(comment)
                }
            } catch {
                print("Error with request: \(error.localizedDescription)")
            }
        }
        CoreDataStack.instance.saveContext()
    }
    
    //MARK: - Read
    
    func getComments(postId: Int? = nil) -> [Comment] {
        let request: NSFetchRequest<CDComment> = CDComment.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: CoreDataKey.Comment.Id, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        if let id = postId {
            request.predicate = NSPredicate(format: "postId = %@", NSNumber(value: id))
        }
        let context = CoreDataStack.context
        var comments = [Comment]()
        do {
            let fetchResult = try context.fetch(request)
            for result in fetchResult {
                comments.append(result.commentFromValues())
            }
        } catch {
            print("Error with request: \(error.localizedDescription)")
        }
        return comments
    }
    
    func getComments(_ id: Int) -> Comment? {
        let request: NSFetchRequest<CDComment> = CDComment.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        let context = CoreDataStack.context
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                let comment = fetchResult[0]
                return comment.commentFromValues()
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    //MARK: - Update
    
    func updateComment(_ comment: Comment){
        let request: NSFetchRequest<CDComment> = CDComment.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", NSNumber(value: comment.id!))
        do {
            let fetchResult = try CoreDataStack.context.fetch(request)
            if (fetchResult.count > 0){
                let object = fetchResult[0]
                object.setCommentValues(comment)
            }
        } catch let error as NSError {
            print("Error with request: \(error.localizedDescription)")
        }
        CoreDataStack.instance.saveContext()
    }
    
    //MARK: - Delete
    
    func deleteComment(_ id: Int){
        do {
            let context = CoreDataStack.context
            let request: NSFetchRequest<CDComment> = CDComment.fetchRequest()
            request.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
            let fetchResult = try context.fetch(request)
            if fetchResult.count != 0 {
                for result in fetchResult {
                    context.delete(result)
                }
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        CoreDataStack.instance.saveContext()
    }
    
    func deleteCommentsOfPost(_ postId: Int){
        do {
            let context = CoreDataStack.context
            let request: NSFetchRequest<CDComment> = CDComment.fetchRequest()
            request.predicate = NSPredicate(format: "postId = %@", NSNumber(value: postId))
            let fetchResult = try context.fetch(request)
            if fetchResult.count != 0 {
                for result in fetchResult {
                    context.delete(result)
                }
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        CoreDataStack.instance.saveContext()
    }
    
    func deleteAllComments(){
        do {
            let context = CoreDataStack.context
            let request: NSFetchRequest<CDComment> = CDComment.fetchRequest()
            let fetchResult = try context.fetch(request)
            if fetchResult.count != 0 {
                for result in fetchResult {
                    context.delete(result)
                }
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        CoreDataStack.instance.saveContext()
    }
}
