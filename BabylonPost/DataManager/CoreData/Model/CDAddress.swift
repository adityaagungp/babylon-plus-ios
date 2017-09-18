//
//  CDAddress+CoreDataClass.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

@objc(CDAddress)
public class CDAddress: NSManagedObject {
    
    @NSManaged public var city: String?
    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var geo: CDGeo?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAddress> {
        return NSFetchRequest<CDAddress>(entityName: CoreDataKey.Entity.Address)
    }
    
    func setAddressValues(_ address: Address?){
        if let address = address {
            setValue(address.city, forKey: CoreDataKey.Address.City)
            setValue(address.street, forKey: CoreDataKey.Address.Street)
            setValue(address.suite, forKey: CoreDataKey.Address.Suite)
            setValue(address.zipcode, forKey: CoreDataKey.Address.Zipcode)
            if let geo = address.geo {
                let geoCD = NSEntityDescription.insertNewObject(forEntityName: CoreDataKey.Entity.Geo, into: CoreDataStack.context) as! CDGeo
                geoCD.setGeoValues(geo)
                setValue(geoCD, forKey: CoreDataKey.Address.Geo)
            }
        }
    }
    
    func addressFromValues() -> Address {
        var address = Address()
        address.city = value(forKey: CoreDataKey.Address.City) as? String
        address.street = value(forKey: CoreDataKey.Address.Street) as? String
        address.suite = value(forKey: CoreDataKey.Address.Suite) as? String
        address.zipcode = value(forKey: CoreDataKey.Address.Zipcode) as? String
        let geoCD = value(forKey: CoreDataKey.Address.Geo) as? CDGeo
        address.geo = geoCD?.geoFromValues()
        return address
    }
}
