//
//  String-Extension.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/27/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation

extension String {
    
    func sanitize() -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_'".characters)
        return String(self.filter { okayChars.contains($0) })
    }
}
