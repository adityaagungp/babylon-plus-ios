//
//  Address.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/12/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Address {
    
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
    
    static func createFromJson(_ json: JSON) -> Address {
        var address = Address()
        address.street = json["street"].string
        address.suite = json["suite"].string
        address.city = json["city"].string
        address.zipcode = json["zipcode"].string
        address.geo = Geo.createFromJson(json["geo"])
        return address
    }
}
