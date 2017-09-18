//
//  CDCompany+CoreDataClass.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

@objc(CDCompany)
public class CDCompany: NSManagedObject {
    
    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var name: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCompany> {
        return NSFetchRequest<CDCompany>(entityName: CoreDataKey.Entity.Company)
    }
    
    func setCompanyValues(_ company: Company?){
        if let company = company {
            setValue(company.bs, forKey: CoreDataKey.Company.Bs)
            setValue(company.catchPhrase, forKey: CoreDataKey.Company.CatchPhrase)
            setValue(company.name, forKey: CoreDataKey.Company.Name)
        }
    }
    
    func companyFromValues() -> Company {
        var company = Company()
        company.bs = value(forKey: CoreDataKey.Company.Bs) as? String
        company.catchPhrase = value(forKey: CoreDataKey.Company.CatchPhrase) as? String
        company.name = value(forKey: CoreDataKey.Company.Name) as? String
        return company
    }
}
