//
//  KeychainManager.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/18/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import KeychainSwift

class KeychainManager {
    
    let keychain = KeychainSwift()
    static let instance = KeychainManager()
    
    func setUsername(_ name: String){
        keychain.set(name, forKey: "Name")
    }
    
    func getUsername() -> String? {
        return keychain.get("Name")
    }
    
    func deleteAllSavedData(){
        keychain.clear()
    }
}
