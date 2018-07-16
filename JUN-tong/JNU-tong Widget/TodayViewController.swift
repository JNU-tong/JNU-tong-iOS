//
//  TodayViewController.swift
//  JNU-tong Widget
//
//  Created by Seong ho Hong on 2018. 3. 8..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet var updateTimeLabel: UILabel!
    @IBOutlet var cityBusView: UIView!
    @IBOutlet var favoriteBusView: UIView!
    @IBOutlet var shuttleBusLabel: UILabel!
    @IBOutlet var aShuttleTime: UILabel!
    @IBOutlet var bShuttleTime: UILabel!
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    let updateDataFormatter = DateFormatter()
    
    let cityBusController = CityBusController()
    var cityBusList = [CityBus]()
    var favoriteBusList = [CityBus]()
    
    let shuttleBusController = ShuttleBusController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        
        updateTimeLabel.text = ""
        cityBusView.backgroundColor = UIColor.clear
        favoriteBusView.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(setBusInfo),
                                               name: NSNotification.Name(rawValue: "setBusInfo"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setShuttleBus),
                                               name: NSNotification.Name(rawValue: "mainShuttleBusSet"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setMainShuttleTime),
                                               name: NSNotification.Name(rawValue: "mainShuttleBusTime"),
                                               object: nil)
        
        setUpdateTime()
        cityBusController.setBusData()
        shuttleBusController.getMainStation()
        shuttleBusController.getMainShuttleTime()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @IBAction func updateButton(_ sender: Any) {
        setUpdateTime()
        cityBusController.setBusData()
        shuttleBusController.getMainStation()
        shuttleBusController.getMainShuttleTime()
    }
    
    @objc func setBusInfo() {
        self.cityBusList = cityBusController.getCityBusList()
        self.favoriteBusList = cityBusController.getFavoriteBusList()
        
        setBus(view: cityBusView, busList: cityBusList, time: 3)
        setBus(view: favoriteBusView, busList: favoriteBusList, time: 10)
    }
    
    @objc private func setShuttleBus(_ notification: Notification) {
        if let mainStation = notification.userInfo!["mainStation"] as? String {
            let main = mainStation.split(separator: "\n")
            
            if main.count > 1 {
                shuttleBusLabel.text = "교내셔틀버스[\(main[0])...]"
            } else {
                shuttleBusLabel.text = "교내셔틀버스[\(mainStation)]"
            }
        }
        shuttleBusLabel.sizeToFit()
    }
    
    @objc private func setMainShuttleTime(_ notification: Notification) {
        var aShuttle = Int()
        var bShuttle = Int()
        
        if let aShuttleTime = notification.userInfo!["aShuttleTime"] as? Int {
            aShuttle = aShuttleTime
        }
        if let bShuttleTime = notification.userInfo!["bShuttleTime"] as? Int {
            bShuttle = bShuttleTime
        }
        
        if aShuttle == -1 {
            aShuttleTime.text = "미운행"
        } else {
            aShuttleTime.text = "\(aShuttle)분전"
        }
        
        if bShuttle == -1 {
            bShuttleTime.text = "미운행"
        } else {
            bShuttleTime.text = "\(bShuttle)분전"
        }
    }
    
    private func startLoading() {
        self.indicator.bounds.size = self.view.bounds.size
        self.indicator.startAnimating()
    }
    
    private func setBus(view: UIView, busList: [CityBus], time: Int) {
        let busCount = busList.count <= 3 ? busList.count : 3
        let busViewCGRect = view.bounds
        
        let busViewHeight = busViewCGRect.size.height
        let busViewWidth = 48
        let busViewBetween = 4
        
        for index in 0..<busCount {
            let cityBus = busList[index]
            
            guard let firstTime = cityBus.firstBusTime else {
                continue
            }
            
            if firstTime > time {
                continue
            }
            
            let x = index*(busViewWidth+busViewBetween) + busViewBetween
            
            let busView = UIView(frame: CGRect(x: x, y: 0, width: busViewWidth, height: Int(busViewHeight)))
            let busLabel = UILabel(frame: CGRect(x: 0, y: 0, width: busViewWidth, height: Int(busViewHeight)))
            
            busLabel.text = "\(cityBus.lineNo)번"
            busLabel.textColor = UIColor.white
            busView.addSubview(busLabel)
            busLabel.textAlignment = .center
            busLabel.font = UIFont.systemFont(ofSize: 14.0)
            busLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
            
            busView.backgroundColor = cityBus.cityBusColor
            busView.layer.cornerRadius = 4
            view.addSubview(busView)
        }
    }
    
    private func setUpdateTime() {
        let updateData = Date()
        updateDataFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        let updateTimeResult = updateDataFormatter.string(from: updateData)
        updateTimeLabel.text = updateTimeResult
    }
}
