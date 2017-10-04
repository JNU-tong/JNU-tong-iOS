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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityBusTimeTable.dataSource = self
        self.cityBusTimeTable.delegate = self
    }
}
extension CityBusTimeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cityBusTime", for: indexPath) as? CityBusTimeCell {
            return cell
        }
        
        return UITableViewCell()
    }
}
