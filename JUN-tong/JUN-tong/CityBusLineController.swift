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
    var cityBusDepartTimeInfo: [String] = []
    var cityBusRemainTimeInfo: [Int] = []
    
    func setBusLineData(lineId: String) {
        ServerRepository.getCityBusLineData(lineId: lineId) { cityBusLineData in
            self.cityBusLineInfo = cityBusLineData
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "busLineInfo"), object: nil, userInfo: ["lineData": self.cityBusLineInfo])
        }
    }
    
    func setBusTimeData(lineId: String) {
        ServerRepository.getCityBusTimeData(lineId: lineId) { cityBusTimeData in
            
            for i in 0..<cityBusTimeData.0.count {
                
                if cityBusTimeData.1[i] != -1 {
                    self.cityBusDepartTimeInfo.append(cityBusTimeData.0[i])
                    self.cityBusRemainTimeInfo.append(cityBusTimeData.1[i])
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "busTimeInfo"), object: nil, userInfo: ["departData": self.cityBusDepartTimeInfo, "remainData": self.cityBusRemainTimeInfo])
        }
    }
}
