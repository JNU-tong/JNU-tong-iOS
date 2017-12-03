//
//  CityBusTimeCell.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 4..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class CityBusTimeCell: UITableViewCell {

    @IBOutlet weak var departTimeLabel: UILabel!
    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var cityBusTimeCell: UIView!

    func setCustone(departTime: String, reaminTime: Int, cellColor: UIColor) {
        departTimeLabel.text = departTime
        remainTimeLabel.text = "\(reaminTime)분전"
        cityBusTimeCell.backgroundColor = cellColor.withAlphaComponent(0.1)
    }
}
