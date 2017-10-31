//
//  CityBusLineCell.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 1..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class CityBusLineCell: UITableViewCell {
    
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var cityBusLineCell: UIView!
    
    func setCustom(stationName: String, cellColor: UIColor) {
        stationNameLabel.text = stationName
        cityBusLineCell.backgroundColor = cellColor.withAlphaComponent(0.1)
    }
}
