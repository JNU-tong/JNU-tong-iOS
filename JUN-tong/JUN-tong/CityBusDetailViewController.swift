//
//  CityBusDetailViewController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 9. 30..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class CityBusDetailViewController: UIViewController {
    
    @IBOutlet weak var busNoLabel: UILabel!
    @IBOutlet weak var busLineLabel: UILabel!
    @IBOutlet weak var busImageView: UIView!

    @IBOutlet weak var busTimeClickStatus: UIView!
    @IBOutlet weak var busLineClickStatus: UIView!
    
    @IBOutlet weak var busLineView: UIView!
    @IBOutlet weak var busTimeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busImageView.layer.borderColor = UIColor.red.cgColor
        busImageView.layer.borderWidth = 3
        busImageView.layer.cornerRadius = 36
        
        busTimeClickStatus.layer.backgroundColor = UIColor.white.cgColor
        
        busLineView.alpha = 1
        busTimeView.alpha = 0
    }
    
    @IBAction func timeTableButton(_ sender: Any) {
        busLineClickStatus.layer.backgroundColor = UIColor.white.cgColor
        busTimeClickStatus.layer.backgroundColor = UIColor.darkGray.cgColor
        
        UIView.animate(withDuration: 0.5, animations: {
            self.busLineView.alpha = 0
            self.busTimeView.alpha = 1
        })
    }
    
    @IBAction func busLineButton(_ sender: Any) {
        busTimeClickStatus.layer.backgroundColor = UIColor.white.cgColor
        busLineClickStatus.layer.backgroundColor = UIColor.darkGray.cgColor
        
        UIView.animate(withDuration: 0.5, animations: {
            self.busLineView.alpha = 1
            self.busTimeView.alpha = 0
        })
    }
}
