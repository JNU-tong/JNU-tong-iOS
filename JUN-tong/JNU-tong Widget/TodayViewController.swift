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
    let updateDataFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel.text = ""
        setUpdateTime()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
    private func setUpdateTime() {
        let updateData = Date()
        updateDataFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        let updateTimeResult = updateDataFormatter.string(from: updateData)
        updateTimeLabel.text = updateTimeResult
    }
    
    @IBAction func updateButton(_ sender: Any) {
        setUpdateTime()
    }
}
