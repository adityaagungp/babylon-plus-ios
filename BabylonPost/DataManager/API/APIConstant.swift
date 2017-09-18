//
//  APIConstant.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation

enum APIConstant {
    
    static let baseUrl = "https://jsonplaceholder.typicode.com"
    
    enum Route {
        static let Posts = "/posts"
        static let Comments = "/comments"
        static let Users = "/users"
    }
}
