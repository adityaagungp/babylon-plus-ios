//
//  Company.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/12/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Company {
    
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    static func createFromJson(_ json: JSON) -> Company {
        var company = Company()
        company.name = json["name"].string
        company.catchPhrase = json["catchPhrase"].string
        company.bs = json["bs"].string
        return company
    }
}
