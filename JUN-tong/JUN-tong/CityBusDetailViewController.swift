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
    
    @IBOutlet weak var busColorView: UIView!
    
    @IBOutlet weak var busLineView: UIView!
    @IBOutlet weak var busTimeView: UIView!
    
    var busInfo: CityBus?
    let cityBusLineController = CityBusLineController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setLine),
                                               name: NSNotification.Name(rawValue: "busLineInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setTime),
                                               name: NSNotification.Name(rawValue: "busTimeInfo"), object: nil)
        
        cityBusLineController.setBusLineData(lineId: (busInfo?.lineId)!)
        cityBusLineController.setBusTimeData(lineId: (busInfo?.lineId)!)
        
        busColorView.backgroundColor = busInfo?.cityBusColor
        busImageView.layer.borderColor = busInfo?.cityBusColor.cgColor
        busImageView.layer.borderWidth = 3
        busImageView.layer.cornerRadius = 36
        
        busTimeClickStatus.layer.backgroundColor = UIColor.white.cgColor
        
        busLineView.alpha = 1
        busTimeView.alpha = 0
        
        busNoLabel.textColor = busInfo?.cityBusColor
        busNoLabel.text = busInfo!.lineNo
        busLineLabel.textColor = busInfo?.cityBusColor
        busLineLabel.text = busInfo!.description
    }
    
    @objc private func setLine(_ notification: Notification) {
        let cityBusLine = notification.userInfo!["lineData"] as! [String]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setBusLineInfo"), object: nil, userInfo: ["lineData": cityBusLine])
    }
    
    @objc private func setTime(_ notification: Notification) {
        let cityBusTime = notification.userInfo!["departData"] as! [String]
        let cityBusRemainTime = notification.userInfo!["remainData"] as! [Int]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setBusTimeInfo"), object: nil, userInfo: ["departTime": cityBusTime, "remainTime": cityBusRemainTime])
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
