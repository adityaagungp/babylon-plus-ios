//
//  CoreDataUser.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    //MARK: - Create
    
    func insertUser(_ user: User){
        let userCD = NSEntityDescription.insertNewObject(forEntityName: CoreDataKey.Entity.User, into: context) as! CDUser
        userCD.setUserValues(user, context: context)
        saveContext()
    }
    
    func insertOrUpdateUser(_ user: User){
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        request.predicate = predicateById(id: user.id!)
        do {
            let fetchResult = try context.fetch(request)
            for result in fetchResult {
                context.delete(result)
            }
            let userCD = NSEntityDescription.insertNewObject(forEntityName: CoreDataKey.Entity.User, into: context) as! CDUser
            userCD.setUserValues(user, context: context)
        } catch let error as NSError {
            print("Error with request: \(error.localizedDescription)")
        }
        saveContext()
    }
    
    //MARK: - Read
    
    func getUser(_ id: Int) -> User? {
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        request.predicate = predicateById(id: id)
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                let result = fetchResult[0]
                return result.userFromValues()
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    //MARK: - Update
    
    func updateUser(_ user: User){
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        request.predicate = predicateById(id: user.id!)
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                let result = fetchResult[0]
                result.setUserValues(user, context: context)
            }
        } catch let error as NSError {
            print("Error with request: \(error.localizedDescription)")
        }
        saveContext()
    }
    
    //MARK: - Delete
    
    func deleteUser(_ id: Int){
        do {
            let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
            request.predicate = predicateById(id: id)
            let fetchResult = try context.fetch(request)
            if fetchResult.count != 0 {
                for result in fetchResult {
                    context.delete(result)
                }
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        saveContext()
    }
    
    func deleteAllUsers(){
        do {
            let userRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
            let fetchResult = try context.fetch(userRequest)
            if fetchResult.count != 0 {
                for result in fetchResult {
                    context.delete(result)
                }
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        saveContext()
    }
}
