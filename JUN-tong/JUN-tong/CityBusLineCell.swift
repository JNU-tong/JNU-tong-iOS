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
    
    func setCustom() {
        arrowView.layer.cornerRadius = 7
    }
}