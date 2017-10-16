//
//  CityBusController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 9. 30..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CityBusController {
    var cityBusList:[CityBus] = []
    var favoriteBusList:[CityBus] = []
    var favoriteBusIdArray:[String] = []
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(clickFavoriteHeart),
                                               name: NSNotification.Name(rawValue: "FavoriteHeartClick"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clickUnfavoriteHeart),
                                               name: NSNotification.Name(rawValue: "UnFavoriteHeartClick"), object: nil)
        
        if UserDefaults.standard.object(forKey: "favoriteBusList") != nil {
            favoriteBusIdArray = UserDefaults.standard.stringArray(forKey: "favoriteBusList")!
        }
    }
    
    @objc private func clickFavoriteHeart(_ notification: NSNotification) {
        guard let heartIndexPath = notification.userInfo?["rowIndexPath"] as? IndexPath else {
            return
        }
        
        if let heartClickBus = notification.userInfo?["cityBusInfo"] as? CityBus {
            favoriteBusList.append(heartClickBus)
            favoriteBusIdArray.append(heartClickBus.lineId)
        }
        
        UserDefaults.standard.set(favoriteBusIdArray, forKey: "favoriteBusList")
        cityBusList.remove(at: heartIndexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "favoriteButtonClick"), object: nil, userInfo: nil)
    }
    
    @objc private func clickUnfavoriteHeart(_ notification: NSNotification) {
        if let heartIndexPath = notification.userInfo?["rowIndexPath"] as? IndexPath {
            favoriteBusList.remove(at: heartIndexPath.row)
        }
        
        if let heartClickBus = notification.userInfo?["cityBusInfo"] as? CityBus {
            for i in 0..<favoriteBusIdArray.count {
                if favoriteBusIdArray[i] == heartClickBus.lineId {
                    favoriteBusIdArray.remove(at: i)
                    UserDefaults.standard.set(favoriteBusIdArray, forKey: "favoriteBusList")
                    break;
                }
            }
            cityBusList.append(heartClickBus)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "favoriteButtonClick"), object: nil, userInfo: nil)
    }
    
    @objc private func sortBusTime() {
        self.cityBusList = self.cityBusList.sorted { $0.firstBusTime! < $1.firstBusTime! }
        self.favoriteBusList = self.favoriteBusList.sorted { $0.firstBusTime! < $1.firstBusTime! }
    }
    
    func setBusData() {
        //새로고침
        self.cityBusList = []
        self.favoriteBusList = []
        
        ServerRepository.getCityBusData() { cityBusData in
            //자주가는 버스
            for i in 0..<cityBusData.count {
                if self.favoriteBusIdArray.contains(cityBusData[i].lineId) {
                    self.favoriteBusList.append(cityBusData[i])
                } else {
                    self.cityBusList.append(cityBusData[i])
                }
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setBusInfo"), object: nil, userInfo: nil)
        }
    }
    
    func getCityBusList() -> [CityBus] {
        sortBusTime()
        return self.cityBusList
    }
    
    func getFavoriteBusList() -> [CityBus] {
        sortBusTime()
        return self.favoriteBusList
    }
}
