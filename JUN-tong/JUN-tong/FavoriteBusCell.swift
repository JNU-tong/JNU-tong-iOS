//
//  FavoriteBusCell.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 3..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class FavoriteBusCell: UITableViewCell {
    
    @IBOutlet weak var lineNoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var firstBusArriveTimeLabel: UILabel!
    @IBOutlet weak var secondBusArriveTimeLabel: UILabel!
    
    var cellIndexPath: IndexPath?
    var cityBus: CityBus?
    
    func setBusInfo(busInfo: CityBus, cellIndexPath: IndexPath) {
        self.cellIndexPath = cellIndexPath
        self.cityBus = busInfo
        
        lineNoLabel.text = cityBus?.lineNo
        lineNoLabel.textColor = cityBus?.cityBusColor
        descriptionLabel.text = cityBus?.description
        
        firstBusArriveTimeLabel.text = "\(cityBus?.firstBusTime! ?? 0)분전"
        if cityBus?.secondBusTime != nil {
            let arriveTime = cityBus?.secondBusTime!
            secondBusArriveTimeLabel.text = "\(arriveTime ?? 0)분전"
        } else {
            secondBusArriveTimeLabel.text = "없음"
        }
    }
    
    @IBAction func clickUnFavoriteButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UnFavoriteHeartClick"), object: nil, userInfo: ["rowIndexPath": cellIndexPath!, "cityBusInfo": cityBus!])
    }
}
