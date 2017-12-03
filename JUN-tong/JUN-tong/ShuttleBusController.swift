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

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "mainShuttleBusSet"),
                                        object: nil,
                                        userInfo: ["mainStation": self.mainStation])
    }

    func setShuttleBusIndex(shuttleBusName: String) {
        //aShuttleIndex = aShuttleStation.index(of: shuttleBusName)
        aShuttleIndex = aShuttleStation.index(where: { $0.stationName.elementsEqual(shuttleBusName) })
        //bShuttleIndex = bShuttleStation.index(of: shuttleBusName)
        bShuttleIndex = bShuttleStation.index(where: { $0.stationName.elementsEqual(shuttleBusName)})

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setAShuttleIndex"),
                                        object: nil,
                                        userInfo: ["aShuttleIndex": aShuttleIndex!])
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setBShuttleIndex"),
                                        object: nil,
                                        userInfo: ["bShuttleIndex": bShuttleIndex!])
    }

    func getMainShuttleTime() {
        // 본관
        ServerRepository.getShuttleBusMain(shuttleIndex: 3) { mainShuttleBusTime in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "mainShuttleBusTime"),
                                            object: nil,
                                            userInfo: ["aShuttleTime": mainShuttleBusTime[0], "bShuttleTime": mainShuttleBusTime[1]])
        }
    }

    func getDetailAshuttleTime() {
        ServerRepository.getShuttleBusDetail(shuttleCourse: "A") { firstTime, secondTime  in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setAShuttelTime"),
                                            object: nil,
                                            userInfo: ["ashuttleFirstTime": firstTime, "ashuttleSecondTime": secondTime])
        }
    }

    func getDetailBshuttleTime() {
        ServerRepository.getShuttleBusDetail(shuttleCourse: "B") { firstTime, secondTime  in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setBShuttelTime"),
                                            object: nil,
                                            userInfo: ["bshuttleFirstTime": firstTime, "bshuttleSecondTime": secondTime])
        }
    }
}
