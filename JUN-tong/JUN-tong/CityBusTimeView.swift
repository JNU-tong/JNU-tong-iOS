//
//  CityBusTimeView.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 1..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class CityBusTimeView: UIViewController {
    
    @IBOutlet weak var cityBusTimeTable: UITableView!
    @IBOutlet weak var departTimeLabel: UILabel!
    
    
    var cityBusTimeList:[String] = []
    var cityBusRemainTimeList:[Int] = []
    var cellColor:UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setBusTImeInfo),
                                               name: NSNotification.Name(rawValue: "setBusTimeInfo"), object: nil)
        
        self.cityBusTimeTable.dataSource = self
        self.cityBusTimeTable.delegate = self
        
        cityBusTimeTable.allowsSelection = false
    }
    
    func setBusTImeInfo(_ notification: Notification) {
        self.cityBusTimeList = notification.userInfo!["departTime"] as! [String]
        self.cityBusRemainTimeList = notification.userInfo!["remainTime"] as! [Int]
        let cityBus = notification.userInfo!["busInfo"] as! CityBus
        self.cellColor = cityBus.cityBusColor
        cityBusTimeTable.reloadData()
    }
}
extension CityBusTimeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityBusTimeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cityBusTime", for: indexPath) as? CityBusTimeCell {
            cell.setCustone(departTime: cityBusTimeList[indexPath.row], reaminTime: cityBusRemainTimeList[indexPath.row], cellColor: cellColor!)
            
            return cell
        }
        
        return UITableViewCell()
    }
}
