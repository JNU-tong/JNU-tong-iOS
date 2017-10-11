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
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(clickFavoriteHeart),
                                               name: NSNotification.Name(rawValue: "FavoriteHeartClick"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clickUnfavoriteHeart),
                                               name: NSNotification.Name(rawValue: "UnFavoriteHeartClick"), object: nil)
    }
    
    @objc private func clickFavoriteHeart(_ notification: NSNotification) {
        guard let heartIndexPath = notification.userInfo?["rowIndexPath"] as? IndexPath else {
            return
        }
        
        if let heartClickBus = notification.userInfo?["cityBusInfo"] as? CityBus {
            favoriteBusList.append(heartClickBus)
        }
        
        cityBusList.remove(at: heartIndexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "favoriteButtonClick"), object: nil, userInfo: nil)
    }
    
    @objc private func clickUnfavoriteHeart(_ notification: NSNotification) {
        if let heartIndexPath = notification.userInfo?["rowIndexPath"] as? IndexPath {
            favoriteBusList.remove(at: heartIndexPath.row)
        }
        
        if let heartClickBus = notification.userInfo?["cityBusInfo"] as? CityBus {
            cityBusList.append(heartClickBus)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "favoriteButtonClick"), object: nil, userInfo: nil)
    }
    
    func setBusData() {
        ServerRepository.getCityBusData() { cityBusData in
            self.cityBusList = cityBusData
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setBusInfo"), object: nil, userInfo: nil)
        }
    }
    
    func getCityBusList() -> [CityBus] {
        return self.cityBusList
    }
    
    func getFavoriteBusList() -> [CityBus] {
        return self.favoriteBusList
    }
}
