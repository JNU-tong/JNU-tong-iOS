//
//  MainViewController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 9. 16..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cityBusMain: UIView!
    @IBOutlet weak var shuttleBusMain: UIView!
    
    @IBOutlet weak var cityBusTable: UITableView!
    
    @IBOutlet weak var cityBusInfo: UIView!
    @IBOutlet weak var shuttleBusInfo: UIView!
    
    @IBOutlet weak var arriveBus1: UILabel!
    @IBOutlet weak var arriveBus2: UILabel!
    
    @IBOutlet weak var cityBusTableHeight: NSLayoutConstraint!
    @IBOutlet weak var cityBusInfoHeight: NSLayoutConstraint!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    var cityBusInfoFolder = false
    var shuttleBusInfoFolder = false
    
    // 본래 있던 자리를 알기 위해
    var cityBusCenter: CGPoint?
    var shuttleBusCenter: CGPoint?
    var extensRange: CGFloat?
    
    var cityBusList: [CityBus] = []
    var favoriteBusList: [CityBus] = []
    
    let cityBusController = CityBusController()
    
    var cityBusInfoTap: UITapGestureRecognizer?
    var shuttleBusInfoTap: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setBusInfo),
                                               name: NSNotification.Name(rawValue: "setBusInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clickFavoriteButton),
                                               name: NSNotification.Name(rawValue: "favoriteButtonClick"), object: nil)
        //loading Data...
        cityBusController.setBusData()
        startLoading()
        
        //set button animation(애니메이션 설정만)  ->  로딩중에 애니메이션 설정만 하기로
        cityBusInfoTap = UITapGestureRecognizer(target: self, action: #selector(self.cityBusInfoTap(_:)))
        cityBusInfoTap?.delegate = self
        
        shuttleBusInfoTap = UITapGestureRecognizer(target: self, action: #selector(self.shuttleBusInfoTap(_:)))
        shuttleBusInfoTap?.delegate = self
        
        //custom mainView
        cityBusCenter = cityBusMain.center
        shuttleBusCenter = shuttleBusMain.center
        extensRange = self.view.bounds.height-25-180
        
        cityBusMain.layer.borderColor = UIColor.darkGray.cgColor
        cityBusMain.layer.borderWidth = 0.5
        cityBusMain.layer.cornerRadius = 7
        
        shuttleBusMain.layer.borderColor = UIColor.darkGray.cgColor
        shuttleBusMain.layer.borderWidth = 0.5
        shuttleBusMain.layer.cornerRadius = 7
        
        self.cityBusTable.delegate = self
        self.cityBusTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetData(_ sender: Any) {
        cityBusTable.allowsSelection = false
        cityBusController.setBusData()
        startLoading()
    }
    
    // setSoonBusInfo 랑 clickButton 이랑 같이 작동할 경우 어플이 죽음....
    @objc private func setBusInfo() {
        self.cityBusList = cityBusController.getCityBusList()
        self.favoriteBusList = cityBusController.getFavoriteBusList()
        cityBusTable.reloadData()
        cityBusTable.allowsSelection = true
        finishLoading()
        setSoonBusInfo()
    }
    
    @objc private func clickFavoriteButton() {
        self.cityBusList = cityBusController.getCityBusList()
        self.favoriteBusList = cityBusController.getFavoriteBusList()
        cityBusTable.reloadData()
    }
    
    private func setSoonBusInfo() {
        var arriveBus: [CityBus] = []
        
        for i in 0..<favoriteBusList.count {
            if favoriteBusList[i].firstBusTime! < 3 && arriveBus.count < 2 {
                arriveBus.append(favoriteBusList[i])
            }
        }
        
        for i in 0..<cityBusList.count {
            if cityBusList[i].firstBusTime! < 3 && arriveBus.count < 2 {
                arriveBus.append(cityBusList[i])
            }
        }
        
        if arriveBus.count == 2 {
            arriveBus1.text = arriveBus[0].lineNo
            arriveBus1.textColor = UIColor.white
            arriveBus1.backgroundColor = arriveBus[0].cityBusColor
            arriveBus1.layer.cornerRadius = 5
            arriveBus1.layer.masksToBounds = true
            arriveBus2.text = arriveBus[1].lineNo
            arriveBus2.textColor = UIColor.white
            arriveBus2.backgroundColor = arriveBus[0].cityBusColor
            arriveBus2.layer.cornerRadius = 5
            arriveBus2.layer.masksToBounds = true
        } else if arriveBus.count == 1{
            arriveBus1.text = arriveBus[0].lineNo
            arriveBus1.textColor = UIColor.white
            arriveBus1.backgroundColor = arriveBus[0].cityBusColor
            arriveBus1.layer.cornerRadius = 5
            arriveBus1.layer.masksToBounds = true
            arriveBus2.isHidden = true
        } else {
            arriveBus1.isHidden = true
            arriveBus2.isHidden = true
        }
    }
    
    private func startLoading() {
        activeIndicator.startAnimating()
        activeIndicator.isHidden = false
        
        if cityBusInfoTap != nil && shuttleBusInfoTap != nil {
            self.cityBusInfo.removeGestureRecognizer(cityBusInfoTap!)
            self.shuttleBusInfo.removeGestureRecognizer(shuttleBusInfoTap!)
        }
    }
    
    private func finishLoading() {
        activeIndicator.stopAnimating()
        activeIndicator.isHidden = true
        
        if cityBusInfoTap != nil && shuttleBusInfoTap != nil {
            self.cityBusInfo.addGestureRecognizer(cityBusInfoTap!)
            self.shuttleBusInfo.addGestureRecognizer(shuttleBusInfoTap!)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cityBusSegue" {
            if let indexPath = cityBusTable.indexPathForSelectedRow {
                if indexPath.section == 0 {
                    let busInfo = favoriteBusList[indexPath.row]
                    let cityBusView = segue.destination as! CityBusDetailViewController
                    
                    cityBusView.busInfo = busInfo
                } else if indexPath.section == 1 {
                    let busInfo = cityBusList[indexPath.row]
                    let cityBusView = segue.destination as! CityBusDetailViewController
                    
                    cityBusView.busInfo = busInfo
                }
            }
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 && favoriteBusList.count == 0{
            return 0
        }
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favoriteBusList.count
        } else {
            return cityBusList.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        if section == 0 {
            let headerText = UILabel()
            headerText.text = "자주타는 버스"
            headerText.textColor = UIColor.init(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1)
            headerText.frame = CGRect(x: 15, y: 10, width: 100, height: 25)
            headerText.font = UIFont.boldSystemFont(ofSize: 14)
            headerView.addSubview(headerText)
            headerView.layer.backgroundColor = UIColor.init(red: CGFloat(238.0 / 255.0), green: CGFloat(238.0 / 255.0), blue: CGFloat(238.0 / 255.0), alpha: 1).cgColor
            return headerView
        } else if section == 1 {
            let headerText = UILabel()
            headerText.text = "도착예정 버스"
            headerText.textColor = UIColor.init(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1)
            headerText.frame = CGRect(x: 15, y: 10, width: 100, height: 25)
            headerText.font = UIFont.boldSystemFont(ofSize: 14)
            headerView.addSubview(headerText)
            headerView.layer.backgroundColor = UIColor.init(red: CGFloat(238.0 / 255.0), green: CGFloat(238.0 / 255.0), blue: CGFloat(238.0 / 255.0), alpha: 1).cgColor
            return headerView
        } else {
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==1, let cell = tableView.dequeueReusableCell(withIdentifier: "cityBusCell", for: indexPath) as? CityBusCell {
            cell.setBusInfo(busInfo: cityBusList[indexPath.row], cellIndexPath:  indexPath)
            
            return cell
        } else if indexPath.section==0, let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteBusCell", for: indexPath) as? FavoriteBusCell {
            cell.setBusInfo(busInfo: favoriteBusList[indexPath.row], cellIndexPath:  indexPath)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    func cityBusInfoTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        if cityBusInfoFolder == false {
            self.cityBusInfoFolder = true
        
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.cityBusMain.frame.size.height += self.extensRange!
                self.cityBusTableHeight.constant += self.extensRange!
                self.cityBusTable.frame.size.height += self.extensRange!
                self.cityBusInfoHeight.constant += self.extensRange!
                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: self.shuttleBusMain.frame.height + self.view.bounds.height)
            })
        } else if cityBusInfoFolder == true {
            self.cityBusInfoFolder = false
            
            UIView.animate(withDuration: 0.5, delay: 0, animations: {

                self.cityBusMain.frame.size.height -= self.extensRange!
                self.cityBusTableHeight.constant -= self.extensRange!
                self.cityBusTable.frame.size.height -= self.extensRange!
                self.cityBusInfoHeight.constant -= self.extensRange!
                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: (self.shuttleBusCenter?.y)!)
            })
        }
    }
    
    func shuttleBusInfoTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        if shuttleBusInfoFolder == false {
            shuttleBusInfoFolder = true
            
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: (self.cityBusCenter?.y)!)
                self.shuttleBusMain.frame.size.height += self.extensRange!
                
                self.cityBusMain.isHidden = true
            })
        } else if shuttleBusInfoFolder == true {
            shuttleBusInfoFolder = false
            
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.shuttleBusMain.frame.size.height -= self.extensRange!
                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: (self.shuttleBusCenter?.y)!)
                
                self.cityBusMain.isHidden = false
            })
        }
    }
}
