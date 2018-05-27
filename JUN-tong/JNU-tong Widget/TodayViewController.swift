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
    
    let updateDataFormatter = DateFormatter()
    
    let cityBusController = CityBusController()
    var cityBusList = [CityBus]()
    var favoriteBusList = [CityBus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel.text = ""
        cityBusView.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(setBusInfo),
                                               name: NSNotification.Name(rawValue: "setBusInfo"),
                                               object: nil)
        
        setUpdateTime()
        cityBusController.setBusData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @objc func setBusInfo() {
        cityBusList = cityBusController.getCityBusList()
        favoriteBusList = cityBusController.getFavoriteBusList()
        setArriveSoonCityBus()
    }
    
    @IBAction func updateButton(_ sender: Any) {
        setUpdateTime()
        setArriveSoonCityBus()
    }
    
    private func setArriveSoonCityBus() {
        let cityBusCount = cityBusList.count <= 3 ? cityBusList.count : 3
        let busViewCGRect = cityBusView.bounds
        
        let busViewHeight = busViewCGRect.size.height
        let busViewWidth = 48
        let busViewBetween = 4
        
        for index in 0..<cityBusCount {
            let cityBus = cityBusList[index]
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
            cityBusView.addSubview(busView)
        }
    }
    
    private func setUpdateTime() {
        let updateData = Date()
        updateDataFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        let updateTimeResult = updateDataFormatter.string(from: updateData)
        updateTimeLabel.text = updateTimeResult
    }
}
