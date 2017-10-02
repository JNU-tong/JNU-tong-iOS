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
    
    var table: UITableView = UITableView()
    var tableIndexPath: IndexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTableAndIndexPath(table: UITableView, indexPath: IndexPath) {
        self.table = table
        self.tableIndexPath = indexPath
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
    
    @IBAction func clickFavoriteButton(_ sender: Any) {
        
    }
}
