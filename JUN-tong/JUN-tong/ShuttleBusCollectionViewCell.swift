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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeView.layer.cornerRadius = timeView.layer.bounds.height/2
        timeView.alpha = 0.3
        
        firstTimeLabel.alpha = 1
    }
}

