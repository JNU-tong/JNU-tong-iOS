//
//  CityBusLineController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 2..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation

class CityBusLineController {
    var cityBusLineInfo: [String] = []
    
    init() {
        cityBusLineInfo = cityBusLineJsonData(resource: "Bus_Line")
    }
    
    private func cityBusLineJsonData(resource: String) -> [String] {
        var cityBusLineList: [String] = []
        
        guard let path = Bundle.main.url(forResource: resource, withExtension: "json") else {
            NSLog("path 오류")
            return []
        }
        
        
        do {
            let data = try String(contentsOf: path).data(using: .utf8)
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            if let arr = json as? [[String : Any]] {
                for value in arr{
                    if let busLineInfo = value["stationName"] {
                        cityBusLineList.append(busLineInfo as! String)
                    }
                }
                return cityBusLineList
            }
            
        } catch let err as NSError {
            print("json data 변경 에러 : \(err)")
        }
        
        return []
    }
    
    public func getCityBusLineList() -> [String]{
        return self.cityBusLineInfo
    }
}
