//
//  Geo.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/12/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Geo {
    
    var lat: Double?
    var lng: Double?
    
    static func createFromJson(_ json: JSON) -> Geo {
        var geo = Geo()
        geo.lat = json["lat"].doubleValue
        geo.lng = json["lng"].doubleValue
        return geo
    }
}
