//
//  CityBus.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 9. 28..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation

struct CityBus {
    func readJsonData(resource: String) -> [Any] {
        guard let path = Bundle.main.url(forResource: resource, withExtension: "json") else {
            NSLog("path 오류")
            return []
        }
        
        do {
            let data = try String(contentsOf: path).data(using: .utf8)
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            if let arr = json as? [Any] {
                return arr
            }
            
        } catch let err as NSError {
            print("json data 변경 에러 : \(err)")
        }
        return []
    }
    
}
