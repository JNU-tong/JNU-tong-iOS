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
    func numberOfSections(in tableView: UITableView) -> Int {
        if cityBusHome{
            return 1
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if cityBusHome {
            return 0
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if cityBusHome {
            return nil
        } else {
            let headerView = UIView()
            if section == 0{
                let headerText = UILabel()
                headerText.text = "자주타는 버스"
                headerText.textColor = UIColor.init(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1)
                headerText.frame = CGRect(x: 15, y: 10, width: 100, height: 25)
                headerText.font = UIFont.boldSystemFont(ofSize: 14)
                headerView.addSubview(headerText)
                headerView.layer.backgroundColor = UIColor.init(red: CGFloat(238.0 / 255.0), green: CGFloat(238.0 / 255.0), blue: CGFloat(238.0 / 255.0), alpha: 1).cgColor
                return headerView
            } else {
                let headerText = UILabel()
                headerText.text = "도착예정 버스"
                headerText.textColor = UIColor.init(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1)
                headerText.frame = CGRect(x: 15, y: 10, width: 100, height: 25)
                headerText.font = UIFont.boldSystemFont(ofSize: 14)
                headerView.addSubview(headerText)
                headerView.layer.backgroundColor = UIColor.init(red: CGFloat(238.0 / 255.0), green: CGFloat(238.0 / 255.0), blue: CGFloat(238.0 / 255.0), alpha: 1).cgColor
                return headerView
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cityBusHome {
            return 1
        } else{
            if section == 0 {
                return 3
            } else {
                return 4
            }
        }
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
                DispatchQueue.main.async {
                    self.cityBusTable.reloadData()
                }
                UIView.animate(withDuration: 0.5,delay: 0, animations: {
                    self.cityBusView.frame.size.height += CGFloat(8 * 44)
                    self.cityBusTable.frame.size.height += CGFloat(8 * 44)
                })
            }
        }
    }
}
