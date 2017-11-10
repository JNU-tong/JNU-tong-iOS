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
    @IBOutlet weak var busImage: UIImageView!
    
    @IBOutlet weak var busLineButtonOutlet: UIButton!
    @IBOutlet weak var busTimeButtonOutlet: UIButton!
    
    @IBOutlet weak var busColorView: UIView!
    
    @IBOutlet weak var busLineView: UIView!
    @IBOutlet weak var busTimeView: UIView!
    
    var busInfo: CityBus?
    let cityBusLineController = CityBusLineController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigation custom
        self.navigationController?.navigationBar.tintColor = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = ["NSColor": UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1)]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationItem.title = "상세정보"
        
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
        
        busLineView.alpha = 1
        busTimeView.alpha = 0
        
        busNoLabel.textColor = busInfo?.cityBusColor
        busNoLabel.text = busInfo!.lineNo
        busLineLabel.text = busInfo!.description
        
        setBusLineImage()
        setBusImage()
    }
    
    private func setBusImage() {
        
        if busInfo?.cityBusType.rawValue == 1 {
            self.busImage.image = #imageLiteral(resourceName: "nightBus")
        } else if busInfo?.cityBusType.rawValue == 2 {
            self.busImage.image = #imageLiteral(resourceName: "blueBus")
        } else if busInfo?.cityBusType.rawValue == 3 {
            self.busImage.image = #imageLiteral(resourceName: "blueBus")
        } else if busInfo?.cityBusType.rawValue == 4 {
            self.busImage.image = #imageLiteral(resourceName: "greenBus")
        }
    }
    
    private func setBusLineImage() {
        if busInfo?.cityBusType.rawValue == 1 {
            self.busLineButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "nightBusLine"), for: .normal)
        } else if busInfo?.cityBusType.rawValue == 2 {
            self.busLineButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "blueBusLine"), for: .normal)
        } else if busInfo?.cityBusType.rawValue == 3 {
            self.busLineButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "blueBusLine"), for: .normal)
        } else if busInfo?.cityBusType.rawValue == 4 {
            self.busLineButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "greenBusLine"), for: .normal)
        }
    }
    
    private func setBusTimeImage() {
        if busInfo?.cityBusType.rawValue == 1 {
            self.busTimeButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "nightBusTime"), for: .normal)
        } else if busInfo?.cityBusType.rawValue == 2 {
            self.busTimeButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "blueBusTime"), for: .normal)
        } else if busInfo?.cityBusType.rawValue == 3 {
            self.busTimeButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "blueBusTime"), for: .normal)
        } else if busInfo?.cityBusType.rawValue == 4 {
            self.busTimeButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "greenBusTime"), for: .normal)
        }
    }
    
    @objc private func setLine(_ notification: Notification) {
        let cityBusLine = notification.userInfo!["lineData"] as! [String]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setBusLineInfo"), object: nil, userInfo: ["lineData": cityBusLine, "busInfo": busInfo!])
    }
    
    @objc private func setTime(_ notification: Notification) {
        let cityBusTime = notification.userInfo!["departData"] as! [String]
        let cityBusRemainTime = notification.userInfo!["remainData"] as! [Int]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setBusTimeInfo"), object: nil, userInfo: ["departTime": cityBusTime, "remainTime": cityBusRemainTime, "busInfo": busInfo!])
    }
    
    @IBAction func timeTableButton(_ sender: Any) {
        busLineButtonOutlet.setBackgroundImage(nil, for: .normal)
        setBusTimeImage()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.busLineView.alpha = 0
            self.busTimeView.alpha = 1
        })
    }
    
    @IBAction func busLineButton(_ sender: Any) {
        busTimeButtonOutlet.setBackgroundImage(nil, for: .normal)
        setBusLineImage()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.busLineView.alpha = 1
            self.busTimeView.alpha = 0
        })
    }
}
