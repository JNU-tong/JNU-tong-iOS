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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBusInfo(busInfo: CityBus) {
        lineNoLabel.text = busInfo.lineNo
        descriptionLabel.text = busInfo.description
        
        firstBusArriveTimeLabel.text = "\(busInfo.firstBusTime!)분전"
        if busInfo.secondBusTime != nil {
            let arriveTime = busInfo.secondBusTime!
            secondBusArriveTimeLabel.text = "\(arriveTime)분전"
        } else {
            secondBusArriveTimeLabel.text = "없음"
        }
    }
}
