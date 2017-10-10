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
    
    func setBusLineData(lineId: String) {
        ServerRepository.getCityBusLineData(lineId: lineId) { cityBusLineData in
            self.cityBusLineInfo = cityBusLineData
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "busLineInfo"), object: nil, userInfo: ["lineData": self.cityBusLineInfo])
        }
    }
}
