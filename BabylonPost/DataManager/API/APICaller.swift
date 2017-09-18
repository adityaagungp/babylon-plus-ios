//
//  APICaller.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APICaller {
    
    static let instance = APICaller()
    
    func getRequest(_ url: String,
                    headers: [String: String]?,
                    parameters: [String: Any],
                    onSuccess successCallback: ((JSON) -> Void)?,
                    onFailure failureCallback: ((String) -> Void)?) {
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback {
                    callback(error.localizedDescription)
                }
            }
        }
    }
    
    func postRequest(_ url: String,
                     headers: [String: String]?,
                     parameters: [String: Any],
                     successCallback: ((JSON) -> Void)?,
                     failureCallback: ((String) -> Void)?) {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback {
                    callback(error.localizedDescription)
                }
            }
        }
    }
}
