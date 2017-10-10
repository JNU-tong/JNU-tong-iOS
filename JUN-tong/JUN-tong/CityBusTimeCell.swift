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
    
    func setCustone(departTime: String, reaminTime: Int) {
        departTimeLabel.text = departTime
        remainTimeLabel.text = "\(reaminTime)분전"
    }
}
