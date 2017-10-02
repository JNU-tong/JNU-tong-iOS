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
    
    let cityBusLineController = CityBusLineController()
    var cityBusLineList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityBusLineList = cityBusLineController.getCityBusLineList()
        
        self.cityBusLineTable.dataSource = self
        self.cityBusLineTable.delegate = self
    }
}
extension CityBusLineView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityBusLineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cityBusLine", for: indexPath) as? CityBusLineCell {
            cell.setCustom(stationName: cityBusLineList[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}
