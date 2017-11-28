//
//  MainViewController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 9. 16..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIView!
    @IBOutlet weak var mainImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainImageHeight: NSLayoutConstraint!
    
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
    
    @IBOutlet weak var shuttleStationLabel: UILabel!
    
    @IBOutlet weak var aShuttleTime: UILabel!
    @IBOutlet weak var bShuttleTime: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    
    @IBOutlet weak var updateTimeLabel: UILabel!
    var cityBusInfoFolder = false
    var shuttleBusInfoFolder = false
    
    var loadingFlag = false
    
    // 본래 있던 자리를 알기 위해
    var cityBusCenter: CGPoint?
    var shuttleBusCenter: CGPoint?
    var imageExtensRange: CGFloat?
    var extensRange: CGFloat?
    
    var cityBusList: [CityBus] = []
    var favoriteBusList: [CityBus] = []
    
    let cityBusController = CityBusController()
    let shuttleBusController = ShuttleBusController()
    
    var cityBusInfoTap: UITapGestureRecognizer?
    var shuttleBusInfoTap: UITapGestureRecognizer?
    
    var mainStation: String?
    
    let date = Date()
    let formatter = DateFormatter()
    let updateDataFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //custom mainView
        cityBusCenter = cityBusMain.center
        shuttleBusCenter = shuttleBusMain.center
        extensRange = self.view.bounds.height-25-180
        imageExtensRange = self.view.bounds.height/2.5
        
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.mainImage.frame.size.height += self.imageExtensRange!
            self.mainImageView.frame.size.height += self.imageExtensRange!
            self.mainImageHeight.constant += self.imageExtensRange!
            self.mainImageViewHeight.constant += self.imageExtensRange!
        })
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setBusInfo),
                                               name: NSNotification.Name(rawValue: "setBusInfo"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clickFavoriteButton),
                                               name: NSNotification.Name(rawValue: "favoriteButtonClick"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setMainShuttleBus),
                                               name: NSNotification.Name(rawValue: "mainShuttleBusSet"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setMainShuttleTime),
                                               name: NSNotification.Name(rawValue: "mainShuttleBusTime"),
                                               object: nil)
        
        //loading Data...
        cityBusController.setBusData()
        startLoading()
        loadingFlag = true
        
        shuttleBusController.getMainStation()
        shuttleBusController.getMainShuttleTime()
        
        //set button animation(애니메이션 설정만)  ->  로딩중에 애니메이션 설정만 하기로
        cityBusInfoTap = UITapGestureRecognizer(target: self, action: #selector(self.cityBusInfoTap(_:)))
        cityBusInfoTap?.delegate = self
        
        shuttleBusInfoTap = UITapGestureRecognizer(target: self, action: #selector(self.shuttleBusInfoTap(_:)))
        shuttleBusInfoTap?.delegate = self
        
        self.cityBusInfo.addGestureRecognizer(cityBusInfoTap!)
        self.shuttleBusInfo.addGestureRecognizer(shuttleBusInfoTap!)
        
        cityBusMain.layer.cornerRadius = 7
        cityBusMain.layer.shadowColor = UIColor.black.cgColor
        cityBusMain.layer.shadowOpacity = 0.5
        cityBusMain.layer.shadowOffset = CGSize.zero
        cityBusMain.layer.shadowRadius = 1

        shuttleBusMain.layer.cornerRadius = 7
        shuttleBusMain.layer.shadowColor = UIColor.black.cgColor
        shuttleBusMain.layer.shadowOpacity = 0.5
        shuttleBusMain.layer.shadowOffset = CGSize.zero
        shuttleBusMain.layer.shadowRadius = 1
        
        self.cityBusTable.delegate = self
        self.cityBusTable.dataSource = self
        
        //for date
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let result = formatter.string(from: date)
        todayDate.text = result
        
        setUpdateTime()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigation custom
        self.navigationController?.navigationBar.titleTextAttributes = ["NSColor": UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        resetData(Bool.self)
        shuttleBusController.getMainStation()
        shuttleBusController.getMainShuttleTime()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetData(_ sender: Any) {
        if loadingFlag == false {
            cityBusTable.allowsSelection = false
            cityBusController.setBusData()
            startLoading()
        }
        setUpdateTime()
        loadingFlag = true
    }
    
    @objc private func setMainShuttleTime(_ notification: Notification) {
        let aShuttle = notification.userInfo!["aShuttleTime"] as! Int
        let bShuttle = notification.userInfo!["bShuttleTime"] as! Int
        
        if aShuttle == -1 {
            aShuttleTime.text = "미운행"
        } else {
            aShuttleTime.text = "\(aShuttle)분전"
        }
        
        if bShuttle == -1 {
            bShuttleTime.text = "미운행"
        } else {
            bShuttleTime.text = "\(bShuttle)분전"
        }
    }
    
    @objc private func setMainShuttleBus(_ notification: Notification) {
        mainStation = notification.userInfo!["mainStation"] as? String
        shuttleStationLabel.text = mainStation
    }
    
    @objc private func setBusInfo() {
        self.cityBusList = cityBusController.getCityBusList()
        self.favoriteBusList = cityBusController.getFavoriteBusList()
        cityBusTable.reloadData()
        cityBusTable.allowsSelection = true
        finishLoading()
        setSoonBusInfo()
        loadingFlag = false
    }
    
    @objc private func clickFavoriteButton() {
        self.cityBusList = cityBusController.getCityBusList()
        self.favoriteBusList = cityBusController.getFavoriteBusList()
        cityBusTable.reloadData()
    }
    
    private func setUpdateTime() {
        let updateData = Date()
        updateDataFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        let updateTimeResult = updateDataFormatter.string(from: updateData)
        updateTimeLabel.text = updateTimeResult
    }
    
    private func setSoonBusInfo() {
        var arriveBus: [CityBus] = []
        
        //라벨 초기화
        arriveBus1.isHidden = false
        arriveBus2.isHidden = false
        arriveBus1.reloadInputViews()
        arriveBus2.reloadInputViews()
        
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
            arriveBus2.backgroundColor = arriveBus[1].cityBusColor
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
        
//        if cityBusInfoTap != nil && shuttleBusInfoTap != nil {
//            self.cityBusInfo.removeGestureRecognizer(cityBusInfoTap!)
//            self.shuttleBusInfo.removeGestureRecognizer(shuttleBusInfoTap!)
//        }
    }
    
    private func finishLoading() {
        activeIndicator.stopAnimating()
        activeIndicator.isHidden = true
        
//        if cityBusInfoTap != nil && shuttleBusInfoTap != nil {
//            self.cityBusInfo.addGestureRecognizer(cityBusInfoTap!)
//            self.shuttleBusInfo.addGestureRecognizer(shuttleBusInfoTap!)
//        }
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
        } else if segue.identifier == "shuttleBusSegue" {
            let shuttleBusView = segue.destination as! ShuttleBusDetailViewController
            shuttleBusView.mainStation = self.mainStation
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
            headerText.frame = CGRect(x: 13, y: 10, width: 100, height: 25)
            headerText.font = UIFont.boldSystemFont(ofSize: 14)
            headerView.addSubview(headerText)
            headerView.layer.backgroundColor = UIColor.init(red: CGFloat(238.0 / 255.0), green: CGFloat(238.0 / 255.0), blue: CGFloat(238.0 / 255.0), alpha: 1).cgColor
            return headerView
        } else if section == 1 {
            let headerText = UILabel()
            headerText.text = "출발예정 버스"
            headerText.textColor = UIColor.init(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1)
            headerText.frame = CGRect(x: 13, y: 10, width: 100, height: 25)
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
                self.mainImage.frame.size.height -= self.imageExtensRange!
                self.mainImageView.frame.size.height -= self.imageExtensRange!
                self.mainImageHeight.constant -= self.imageExtensRange!
                self.mainImageViewHeight.constant -= self.imageExtensRange!
               self.cityBusMain.center = CGPoint(x: self.view.bounds.width/2, y: (self.cityBusCenter?.y)!)
                
                self.cityBusMain.frame.size.height += self.extensRange!
                self.cityBusTableHeight.constant += self.extensRange!
                self.cityBusTable.frame.size.height += self.extensRange!
                self.cityBusInfoHeight.constant += self.extensRange!
                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: self.shuttleBusMain.frame.height + self.view.bounds.height)
            })
        } else if cityBusInfoFolder == true {
            self.cityBusInfoFolder = false
            
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.mainImage.frame.size.height += self.imageExtensRange!
                self.mainImageView.frame.size.height += self.imageExtensRange!
                self.mainImageHeight.constant += self.imageExtensRange!
                self.mainImageViewHeight.constant += self.imageExtensRange!
                self.cityBusMain.center = CGPoint(x: self.view.bounds.width/2, y: (self.cityBusCenter?.y)! + (self.imageExtensRange!) + 100)
                
                self.cityBusMain.frame.size.height -= self.extensRange!
                self.cityBusTableHeight.constant -= self.extensRange!
                self.cityBusTable.frame.size.height -= self.extensRange!
                self.cityBusInfoHeight.constant -= self.extensRange!
                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: (self.shuttleBusCenter?.y)!)
            })
        }
    }
    
    func shuttleBusInfoTap(_ gestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "shuttleBusSegue", sender: self)
    }
    
//    func shuttleBusInfoTap(_ gestureRecognizer: UITapGestureRecognizer) {
//
//        if shuttleBusInfoFolder == false {
//            shuttleBusInfoFolder = true
//
//            UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: (self.cityBusCenter?.y)!)
//                self.shuttleBusMain.frame.size.height += self.extensRange!
//
//                self.cityBusMain.isHidden = true
//            })
//        } else if shuttleBusInfoFolder == true {
//            shuttleBusInfoFolder = false
//
//            UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                self.shuttleBusMain.frame.size.height -= self.extensRange!
//                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: (self.shuttleBusCenter?.y)!)
//
//                self.cityBusMain.isHidden = false
//            })
//        }
//    }
}
