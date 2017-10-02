//
//  CityBusLineCell.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 1..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class CityBusLineCell: UITableViewCell {
    
    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var stationNameLabel: UILabel!
    
    func setCustom(stationName: String) {
        
        arrowView.layer.cornerRadius = 7
        stationNameLabel.text = stationName
    }
}
