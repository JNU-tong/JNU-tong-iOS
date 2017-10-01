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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityBusLineTable.dataSource = self
        self.cityBusLineTable.delegate = self
    }
}
extension CityBusLineView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cityBusLine", for: indexPath) as? CityBusLineCell {
            cell.setCustom()
            return cell
        }
        
        return UITableViewCell()
    }
}
