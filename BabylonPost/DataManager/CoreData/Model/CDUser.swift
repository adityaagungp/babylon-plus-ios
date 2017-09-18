//
//  CDUser+CoreDataClass.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

@objc(CDUser)
public class CDUser: NSManagedObject {
    
    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var username: String?
    @NSManaged public var website: String?
    @NSManaged public var address: CDAddress?
    @NSManaged public var company: CDCompany?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: CoreDataKey.Entity.User)
    }
    
    func setUserValues(_ user: User){
        setValue(user.id, forKey: CoreDataKey.User.Id)
        setValue(user.email, forKey: CoreDataKey.User.Email)
        setValue(user.name, forKey: CoreDataKey.User.Name)
        setValue(user.phone, forKey: CoreDataKey.User.Phone)
        setValue(user.username, forKey: CoreDataKey.User.Username)
        setValue(user.website, forKey: CoreDataKey.User.Website)
        if let address = user.address {
            let addressCD = NSEntityDescription.insertNewObject(forEntityName: CoreDataKey.Entity.Address, into: CoreDataStack.context) as! CDAddress
            addressCD.setAddressValues(address)
            setValue(addressCD, forKey: CoreDataKey.User.Address)
        }
        if let company = user.company {
            let companyCD = NSEntityDescription.insertNewObject(forEntityName: CoreDataKey.Entity.Company, into: CoreDataStack.context) as! CDCompany
            companyCD.setCompanyValues(company)
            setValue(companyCD, forKey: CoreDataKey.User.Company)
        }
    }
    
    func userFromValues() -> User {
        var user = User()
        user.id = value(forKey: CoreDataKey.User.Id) as? Int
        user.email = value(forKey: CoreDataKey.User.Email) as? String
        user.name = value(forKey: CoreDataKey.User.Name) as? String
        user.phone = value(forKey: CoreDataKey.User.Phone) as? String
        user.username = value(forKey: CoreDataKey.User.Username) as? String
        user.website = value(forKey: CoreDataKey.User.Website) as? String
        let addressCD = value(forKey: CoreDataKey.User.Address) as? CDAddress
        user.address = addressCD?.addressFromValues()
        let companyCD = value(forKey: CoreDataKey.User.Company) as? CDCompany
        user.company = companyCD?.companyFromValues()
        return user
    }
}
