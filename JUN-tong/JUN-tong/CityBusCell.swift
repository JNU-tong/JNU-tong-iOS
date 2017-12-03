//
//  CityBusCell.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 9. 18..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class CityBusCell: UITableViewCell {

    @IBOutlet weak var lineNoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var firstBusArriveTimeLabel: UILabel!
    @IBOutlet weak var secondBusArriveTimeLabel: UILabel!

    @IBOutlet weak var favoriteButtonOulet: UIButton!

    var cellIndexPath: IndexPath?
    var cityBus: CityBus?

    func setBusInfo(busInfo: CityBus, cellIndexPath: IndexPath) {
        self.cellIndexPath = cellIndexPath
        self.cityBus = busInfo

        lineNoLabel.text = cityBus?.lineNo
        lineNoLabel.backgroundColor = cityBus?.cityBusColor
        lineNoLabel.textColor = UIColor.white
        lineNoLabel.layer.cornerRadius = 5
        lineNoLabel.layer.masksToBounds = true
        descriptionLabel.text = cityBus?.description

        firstBusArriveTimeLabel.text = "\(cityBus?.firstBusTime! ?? 0)분전"
        if cityBus?.secondBusTime != nil {
            let arriveTime = cityBus?.secondBusTime!
            secondBusArriveTimeLabel.text = "\(arriveTime ?? 0)분전"
        } else {
            secondBusArriveTimeLabel.text = "없음"
        }
    }

    @IBAction func clickFavoriteButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FavoriteHeartClick"),
                                        object: nil,
                                        userInfo: ["rowIndexPath": cellIndexPath!, "cityBusInfo": cityBus!])
    }
}
