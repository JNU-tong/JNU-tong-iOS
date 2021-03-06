//
//  CityBusLineView.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 1..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class CityBusLineView: UIViewController {
    @IBOutlet weak var cityBusLineTable: UITableView!
    var cityBusLineList:[String] = []
    var cellColor:UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setBusLineInfo),
                                               name: NSNotification.Name(rawValue: "setBusLineInfo"), object: nil)

        self.cityBusLineTable.dataSource = self
        self.cityBusLineTable.delegate = self

        cityBusLineTable.allowsSelection = false
    }

    func setBusLineInfo(_ notification: Notification) {
        if let lineData = notification.userInfo!["lineData"] as? [String] {
            self.cityBusLineList = lineData
        }
        if let busInfo = notification.userInfo!["busInfo"] as? CityBus {
            self.cellColor = busInfo.cityBusColor
        }
        cityBusLineTable.reloadData()
    }
}
extension CityBusLineView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityBusLineList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cityBusLine", for: indexPath) as? CityBusLineCell {
            cell.setCustom(stationName: cityBusLineList[indexPath.row], cellColor: cellColor!)
            return cell
        }

        return UITableViewCell()
    }
}
