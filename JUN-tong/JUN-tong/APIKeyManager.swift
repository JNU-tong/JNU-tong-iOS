//
//  APIKeyManager.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2018. 7. 16..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import Foundation

struct APIKeyManager {
    
    static let ServerIP: String = {
        return getAPIKey(keyName: "ServerIP")
    }()
    
    static func getAPIKey(keyName: String) -> String {
        if let path = Bundle.main.path(forResource: "APIKey", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            if let clientSecret = dict[keyName] {
                return clientSecret
            }
        }
        return ""
    }
}
