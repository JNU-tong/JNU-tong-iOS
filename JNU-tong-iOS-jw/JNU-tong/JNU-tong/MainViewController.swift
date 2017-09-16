//
//  MainViewController.swift
//  JNU-tong
//
//  Created by mac on 2017. 9. 15..
//  Copyright © 2017년 tong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
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
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cityBusCellNum
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if tableView == self.cityBusTable {
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cityBus", for: indexPath)
                if cityBusHome {
                    cell?.selectionStyle = UITableViewCellSelectionStyle.none
                }
            } else if indexPath.section == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cityBusListCell", for: indexPath)
                cell?.selectionStyle = UITableViewCellSelectionStyle.gray
                
            }
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.cityBusTable {
            if cityBusHome {
                cityBusHome = false
                UIView.animate(withDuration: 0.5,delay: 0, animations: {
                    self.cityBusView.frame.size.height += self.view.bounds.height-25-180
                    self.cityBusTable.frame.size.height += self.view.bounds.height-25-180
                    self.cityBusTable.isScrollEnabled = true
                })
            } else{
                cityBusHome = true
                UIView.animate(withDuration: 0.5,delay: 0, animations: {
                    self.cityBusView.frame.size.height -= self.view.bounds.height-25-180
                    self.cityBusTable.frame.size.height -= self.view.bounds.height-25-180
                    self.cityBusTable.isScrollEnabled = false
                })
            }
        }
    }
}
