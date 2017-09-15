//
//  MainViewController.swift
//  JNU-tong
//
//  Created by mac on 2017. 9. 15..
//  Copyright © 2017년 tong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var cityBusTable: UITableView!
    @IBOutlet weak var cityBusView: UIView!
    var cityBusCellNum = 1
    var cityBusHome = true
    override func viewDidLoad() {
        super.viewDidLoad()
        cityBusTable.delegate = self
        cityBusTable.dataSource = self
        cityBusTable.isScrollEnabled = false
        
        cityBusView.layer.borderColor = UIColor.darkGray.cgColor
        cityBusView.layer.borderWidth = 0.5
        cityBusView.layer.cornerRadius = 7
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityBusCellNum
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if tableView == self.cityBusTable {
            cell = tableView.dequeueReusableCell(withIdentifier: "cityBus", for: indexPath)
            if cityBusHome {
                cell?.selectionStyle = UITableViewCellSelectionStyle.none
            }
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.cityBusTable {
            if cityBusHome {
                cityBusHome = false
                UIView.animate(withDuration: 0.5,delay: 0, animations: {
                    self.cityBusView.frame.size.height += 400
                })
            } else{
                cityBusHome = true
                UIView.animate(withDuration: 0.5,delay: 0, animations: {
                    self.cityBusView.frame.size.height -= 400
                })
            }
        }
    }
}
