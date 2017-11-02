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
            if stationIndex == 0 {
                stationImage.image = #imageLiteral(resourceName: "stationFrontDoor")
            } else if stationIndex == 1 {
                stationImage.image = #imageLiteral(resourceName: "stationSecondLibrary")
            } else if stationIndex == 2 {
                stationImage.image = #imageLiteral(resourceName: "stationOceanWorld")
            } else if stationIndex == 3 {
                stationImage.image = #imageLiteral(resourceName: "stationJejuCenter")
            } else if stationIndex == 4 {
                stationImage.image = #imageLiteral(resourceName: "stationStudentHall")
            } else if stationIndex == 5 {
                stationImage.image = #imageLiteral(resourceName: "stationHumanWest")
            } else if stationIndex == 6 {
                stationImage.image = #imageLiteral(resourceName: "stationStudentHome")
            } else if stationIndex == 7 {
                stationImage.image = #imageLiteral(resourceName: "stationHumanEast")
            } else if stationIndex == 8 {
                stationImage.image = #imageLiteral(resourceName: "stationCenterLibrary")
            } else if stationIndex == 9 {
                stationImage.image = #imageLiteral(resourceName: "stationMedical")
            } else if stationIndex == 10 {
                stationImage.image = #imageLiteral(resourceName: "stationMachine")
            } else if stationIndex == 11 {
                stationImage.image = #imageLiteral(resourceName: "stationOceanFour")
            } else if stationIndex == 12 {
                stationImage.image = #imageLiteral(resourceName: "stationGeneral")
            } else if stationIndex == 13 {
                stationImage.image = #imageLiteral(resourceName: "stationOceanWorld")
            } else if stationIndex == 14 {
                stationImage.image = #imageLiteral(resourceName: "stationSecondLibrary")
            } else if stationIndex == 15 {
                stationImage.image = #imageLiteral(resourceName: "stationFrontDoor")
            } else {
                stationImage.image = #imageLiteral(resourceName: "example")
            }
        } else {
            if stationIndex == 0 {
                stationImage.image = #imageLiteral(resourceName: "stationFrontDoor")
            } else if stationIndex == 1 {
                stationImage.image = #imageLiteral(resourceName: "stationSecondLibrary")
            } else if stationIndex == 2 {
                stationImage.image = #imageLiteral(resourceName: "stationOceanWorld")
            } else if stationIndex == 3 {
                stationImage.image = #imageLiteral(resourceName: "stationGeneral")
            } else if stationIndex == 4 {
                stationImage.image = #imageLiteral(resourceName: "stationOceanFour")
            } else if stationIndex == 5 {
                stationImage.image = #imageLiteral(resourceName: "stationMachine")
            } else if stationIndex == 6 {
                stationImage.image = #imageLiteral(resourceName: "stationMedical")
            } else if stationIndex == 7 {
                stationImage.image = #imageLiteral(resourceName: "stationCenterLibrary")
            } else if stationIndex == 8 {
                stationImage.image = #imageLiteral(resourceName: "stationHumanEast")
            } else if stationIndex == 9 {
                stationImage.image = #imageLiteral(resourceName: "stationStudentHome")
            } else if stationIndex == 10 {
                stationImage.image = #imageLiteral(resourceName: "stationHumanWest")
            } else if stationIndex == 11 {
                stationImage.image = #imageLiteral(resourceName: "stationStudentHall")
            } else if stationIndex == 12 {
                stationImage.image = #imageLiteral(resourceName: "stationJejuCenter")
            } else if stationIndex == 13 {
                stationImage.image = #imageLiteral(resourceName: "stationOceanWorld")
            } else if stationIndex == 14 {
                stationImage.image = #imageLiteral(resourceName: "stationSecondLibrary")
            } else if stationIndex == 15 {
                stationImage.image = #imageLiteral(resourceName: "stationFrontDoor")
            } else {
                stationImage.image = #imageLiteral(resourceName: "example")
            }
        }
    }
}

