//
//  JsonReader.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 9. 29..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation

class JsonReader {
    
    func readJsonData(resource: String) -> [CityBus] {
        var cityBusList: [CityBus] = []
        
        guard let path = Bundle.main.url(forResource: resource, withExtension: "json") else {
            NSLog("path 오류")
            return []
        }
        var busInfo:[[String : Any]] = [[:]]
        var remainInfo:[[String : Any]] = [[:]]
        
        do {
            let data = try String(contentsOf: path).data(using: .utf8)
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            if let arr = json as? [String : [String : Any]] {
                for (_, value) in arr{
                    if let busLineInfo = value["busLineInfo"] {
                        busInfo.append(busLineInfo as! [String : Any])
                    }
                    
                    if let remainBusInfo = value["remainTime"] {
                        remainInfo.append(remainBusInfo as! [String : Any])
                    }
                }
                
                for i in 0..<busInfo.count {
                    if let lineNo = busInfo[i]["detailLineNo"] as? String,
                        let description = busInfo[i]["description"] as? String,
                        let lineId = busInfo[i]["lineId"] as? String,
                        let firstBusTime = remainInfo[i]["first"] as? Int {
                        
                        //secondBus의 nil 값
                        if let secondBusTime = remainInfo[i]["second"]  as? Int {
                            let cityBus = CityBus(lineNo: lineNo, description: description, lineId: lineId, firstBusTime: firstBusTime, secondBusTime: secondBusTime)
                            cityBusList.append(cityBus)
                        } else {
                            let cityBus = CityBus(lineNo: lineNo, description: description, lineId: lineId, firstBusTime: firstBusTime, secondBusTime: nil)
                            cityBusList.append(cityBus)
                        }
                        
                    }
                }
                
                return cityBusList
            }
            
        } catch let err as NSError {
            print("json data 변경 에러 : \(err)")
        }
        return []
    }
}
