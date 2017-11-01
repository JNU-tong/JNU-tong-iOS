//
//  ShuttleBusController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 31..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation


class ShuttleBusController {
    var mainStation = "본관"
    var aShuttleIndex: Int?
    var bShuttleIndex: Int?
    
    func getMainStation() {
        if UserDefaults.standard.object(forKey: "mainStation") != nil {
            self.mainStation = UserDefaults.standard.string(forKey: "mainStation")!
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "mainShuttleBusSet"), object: nil, userInfo: ["mainStation": self.mainStation])
    }
    
    func setShuttleBusIndex(shuttleBusName: String) {
        aShuttleIndex = AshuttleStation.index(of: shuttleBusName)
        bShuttleIndex = BshuttleStation.index(of: shuttleBusName)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setAShuttleIndex"), object: nil, userInfo: ["aShuttleIndex": aShuttleIndex!])
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setBShuttleIndex"), object: nil, userInfo: ["bShuttleIndex": bShuttleIndex!])
    }
    
    func getMainShuttleTime() {
        ServerRepository.getShuttleBusMain(shuttleIndex: AshuttleStation.index(of: mainStation)!) { mainShuttleBusTime in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "mainShuttleBusTime"), object: nil, userInfo: ["aShuttleTime": mainShuttleBusTime[0], "bShuttleTime": mainShuttleBusTime[1]])
        }
    }
}
