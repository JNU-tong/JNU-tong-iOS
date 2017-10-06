//
//  CityBusController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 9. 30..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation

class CityBusController {
    
    var cityBusList:[CityBus] = []
    var favoriteBusList:[CityBus] = []
    
    init(jsonInfo: String) {
        self.cityBusList = cityBusJsonData(resource: jsonInfo)
        NotificationCenter.default.addObserver(self, selector: #selector(clickFavoriteHeart),
                                               name: NSNotification.Name(rawValue: "FavoriteHeartClick"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clickUnfavoriteHeart),
                                               name: NSNotification.Name(rawValue: "UnFavoriteHeartClick"), object: nil)
    }
    
    private func cityBusJsonData(resource: String) -> [CityBus] {
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
    
    @objc private func clickFavoriteHeart(_ notification: NSNotification) {
        guard let heartIndexPath = notification.userInfo?["rowIndexPath"] as? IndexPath else {
            return
        }
        
        if let heartClickBus = notification.userInfo?["cityBusInfo"] as? CityBus {
            favoriteBusList.append(heartClickBus)
        }
        
        cityBusList.remove(at: heartIndexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "busInfoChange"), object: nil, userInfo: nil)
    }
    
    @objc private func clickUnfavoriteHeart(_ notification: NSNotification) {
        if let heartIndexPath = notification.userInfo?["rowIndexPath"] as? IndexPath {
            favoriteBusList.remove(at: heartIndexPath.row)
        }
        
        if let heartClickBus = notification.userInfo?["cityBusInfo"] as? CityBus {
            cityBusList.append(heartClickBus)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "busInfoChange"), object: nil, userInfo: nil)
    }
    
    public func getCityBusList() -> [CityBus] {
        return self.cityBusList
    }
    
    public func getFavoriteBusList() -> [CityBus] {
        return self.favoriteBusList
    }
}
