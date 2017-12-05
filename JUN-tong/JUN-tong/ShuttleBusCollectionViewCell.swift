//
//  ShuttleBusCollectionViewCell.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 27..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class ShuttleBusCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var firstTimeLabel: UILabel!
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var stationImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        timeView.layer.cornerRadius = timeView.layer.bounds.height/2
        timeView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
    }

    func setShuttleTime(fistTime: Int, secondTime: Int) {
        if fistTime == -1 {
            firstTimeLabel.text = "종료"
        } else {
            firstTimeLabel.text = "\(fistTime)분전"
        }

        if secondTime == -1 {
            secondTimeLabel.text = "종료"
        } else {
            secondTimeLabel.text = "\(secondTime)분전"
        }
    }

    func setStationImage(course: String, stationIndex: Int) {
        if course == "A" {
            stationImage.image = bShuttleStation[stationIndex].stationImage
        } else {
            stationImage.image = bShuttleStation[stationIndex].stationImage
        }
    }
}
