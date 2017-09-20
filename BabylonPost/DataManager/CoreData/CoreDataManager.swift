//
//  CoreDataStack.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/17/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var coreDataStack: CoreDataStack?
    
    var context: NSManagedObjectContext {
        get {
            return (coreDataStack?.persistentContainer.viewContext)!
        }
    }
    
    func saveContext(){
        coreDataStack?.saveContext()
    }
}
