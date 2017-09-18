//
//  CDGeo.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import CoreData

@objc(CDGeo)
public class CDGeo: NSManagedObject {
    
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGeo> {
        return NSFetchRequest<CDGeo>(entityName: CoreDataKey.Entity.Geo)
    }
    
    func setGeoValues(_ geo: Geo?){
        if let geo = geo {
            setValue(geo.lat, forKey: CoreDataKey.Geo.Lat)
            setValue(geo.lng, forKey: CoreDataKey.Geo.Lng)
        }
    }
    
    func geoFromValues() -> Geo {
        var geo = Geo()
        geo.lat = value(forKey: CoreDataKey.Geo.Lat) as? Double
        geo.lng = value(forKey: CoreDataKey.Geo.Lng) as? Double
        return geo
    }
}
