//
//  CoreDataPost.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    //MARK: - Create
    
    func insertPost(_ post: Post){
        let postCD = NSEntityDescription.insertNewObject(forEntityName: CoreDataKey.Entity.Post, into: context) as! CDPost
        postCD.setPostValues(post)
        saveContext()
    }
    
    func insertPosts(_ posts: [Post]){
        for post in posts {
            let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
            request.predicate = predicateById(id: post.id!)
            do {
                let fetchResult = try context.fetch(request)
                if fetchResult.count > 0 {
                    let updatedPost = fetchResult[0]
                    updatedPost.setPostValues(post)
                } else {
                    let postCD = NSEntityDescription.insertNewObject(forEntityName: CoreDataKey.Entity.Post, into: context) as! CDPost
                    postCD.setPostValues(post)
                }
            } catch {
                print("Error with request: \(error.localizedDescription)")
            }
        }
        saveContext()
    }
    
    //MARK: - Read
    
    func getPosts() -> [Post] {
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: CoreDataKey.Post.Id, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        var posts = [Post]()
        do {
            let fetchResult = try context.fetch(request)
            for result in fetchResult {
                posts.append(result.postFromValues())
            }
        } catch {
            print("Error with request: \(error.localizedDescription)")
        }
        return posts
    }
    
    func getPost(_ id: Int) -> Post? {
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        request.predicate = predicateById(id: id)
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                let resultPost = fetchResult[0]
                return resultPost.postFromValues()
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    func getPostsByTerm(_ query: String) -> [Post] {
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: CoreDataKey.Post.Id, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        let sanitizedQuery = query.lowercased().sanitize()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR body CONTAINS[cd] %@", argumentArray: [sanitizedQuery, sanitizedQuery])
        var posts = [Post]()
        do {
            let fetchResult = try context.fetch(request)
            for result in fetchResult {
                posts.append(result.postFromValues())
            }
        } catch {
            print("Error with request: \(error.localizedDescription)")
        }
        return posts
    }
    
    //MARK: - Update
    
    func updatePost(_ post: Post){
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        request.predicate = predicateById(id: post.id!)
        do {
            let fetchResult = try context.fetch(request)
            if (fetchResult.count > 0){
                let updatedPost = fetchResult[0]
                updatedPost.setPostValues(post)
            }
        } catch let error as NSError {
            print("Error with request: \(error.localizedDescription)")
        }
        saveContext()
    }
    
    //MARK: - Delete
    
    func deletePost(_ id: Int){
        do {
            let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
            request.predicate = predicateById(id: id)
            let fetchResult = try context.fetch(request)
            for result in fetchResult {
                context.delete(result)
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        saveContext()
    }
    
    func deleteAllPosts(){
        do {
            let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
            let fetchResult = try context.fetch(request)
            for result in fetchResult {
                context.delete(result)
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        saveContext()
    }
}
