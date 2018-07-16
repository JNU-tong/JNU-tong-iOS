//
//  BShuttleBUsView.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 11. 1..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class BShuttleBusView: UIViewController {
    @IBOutlet weak var bShuttleBusCollectionView: UICollectionView!

    @IBOutlet weak var centerStationLabel: UILabel!
    @IBOutlet weak var leftStationLabel: UILabel!
    @IBOutlet weak var rightStationLabel: UILabel!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!

    @IBOutlet weak var previousStationLabel: UILabel!
    @IBOutlet weak var nextStationLabel1: UILabel!
    @IBOutlet weak var nextStationLabel2: UILabel!
    @IBOutlet weak var nextStationLabel3: UILabel!
    @IBOutlet weak var nextStationLabel4: UILabel!

    let shuttleBusController = ShuttleBusController()
    var prevOffset: CGPoint?
    var bStationIndex: Int?
    var currentIndex: Int?
    var bShuttleFirstTime: [Int] = []
    var bShuttleSecondTime: [Int] = []
    var onceOnly = false

    let defaults = UserDefaults(suiteName: "group.JNU-tong")

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(setShuttleIndex),
                                               name: NSNotification.Name(rawValue: "setBShuttleIndex"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setShuttleTime),
                                               name: NSNotification.Name(rawValue: "setBShuttelTime"), object: nil)

        view.addSubview(bShuttleBusCollectionView)

        bShuttleBusCollectionView.dataSource = self
        bShuttleBusCollectionView.delegate = self

        bShuttleBusCollectionView.register(UINib(nibName: "ShuttleBusInfo", bundle: nil), forCellWithReuseIdentifier: "ShuttleBusInfo")
        setCollectionViewLayout()
    }

    @IBAction func favoriteButtionClick(_ sender: Any) {
        defaults?.set(bShuttleStation[currentIndex!].stationName, forKey: "mainStation")
        defaults?.synchronize()
//        UserDefaults.standard.set(bShuttleStation[currentIndex!].stationName, forKey: "mainStation")
        bStationIndex = currentIndex
        setFavoriteButton(stationIndex: bStationIndex!)
        shuttleBusController.setShuttleBusIndex(shuttleBusName: bShuttleStation[bStationIndex!].stationName)
    }

    @objc func setShuttleIndex(_ notification: Notification) {
        bStationIndex = notification.userInfo!["bShuttleIndex"] as? Int
        currentIndex = bStationIndex
        if let stationIndex = bStationIndex {
            setStationLabel(stationIndex: stationIndex)
            setFavoriteButton(stationIndex: stationIndex)
            setStationLocation(stationIndex: stationIndex)
        }
    }

    @objc func setShuttleTime(_ notification: Notification) {
        // swiftLint fix
        if let bShuttleFirst = notification.userInfo!["bshuttleFirstTime"] as? [Int] {
            bShuttleFirstTime = bShuttleFirst
        }
        if let bShuttleSecond = notification.userInfo!["bshuttleSecondTime"] as? [Int] {
            bShuttleSecondTime = bShuttleSecond
        }

        bShuttleBusCollectionView.reloadData()
    }
    func setFavoriteButton(stationIndex: Int) {
        if bStationIndex == stationIndex {
            favoriteButtonOutlet.setImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
        } else {
            favoriteButtonOutlet.setImage(#imageLiteral(resourceName: "blackHeart"), for: .normal)
        }
    }

    func setCollectionViewLayout() {
        let layout = ShuttleBusCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        layout.itemSize = CGSize(width: self.view.bounds.width - 64 - 10, height: self.view.bounds.height/2 )
        bShuttleBusCollectionView.collectionViewLayout = layout
        bShuttleBusCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }

    func setStationLabel(stationIndex: Int) {
        if stationIndex == 0 {
            self.leftStationLabel.isHidden = true
            self.centerStationLabel.text = bShuttleStation[stationIndex].stationName
            self.rightStationLabel.text = bShuttleStation[stationIndex+1].stationName
        } else if stationIndex == bShuttleStation.count-1 {
            self.leftStationLabel.text = bShuttleStation[stationIndex-1].stationName
            self.centerStationLabel.text = bShuttleStation[stationIndex].stationName
            self.rightStationLabel.isHidden = true
        } else {
            self.rightStationLabel.isHidden = false
            self.leftStationLabel.isHidden = false
            self.leftStationLabel.text = bShuttleStation[stationIndex-1].stationName
            self.centerStationLabel.text = bShuttleStation[stationIndex].stationName
            self.rightStationLabel.text = bShuttleStation[stationIndex+1].stationName
        }
    }

    func setStationLocation(stationIndex: Int) {
        if stationIndex == bShuttleStation.count-1 {
            self.nextStationLabel4.text = ""
            self.nextStationLabel3.text = ""
            self.nextStationLabel2.text = ""
            self.nextStationLabel1.text = ""
            self.previousStationLabel.text = bShuttleStation[stationIndex-1].stationName
        } else if stationIndex == bShuttleStation.count-2 {
            self.nextStationLabel4.text = ""
            self.nextStationLabel3.text = ""
            self.nextStationLabel2.text = ""
            self.nextStationLabel1.text = bShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = bShuttleStation[stationIndex-1].stationName
        } else if stationIndex == bShuttleStation.count-3 {
            self.nextStationLabel4.text = ""
            self.nextStationLabel3.text = ""
            self.nextStationLabel2.text = bShuttleStation[stationIndex+2].stationName
            self.nextStationLabel1.text = bShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = bShuttleStation[stationIndex-1].stationName
        } else if stationIndex == bShuttleStation.count-4 {
            self.nextStationLabel4.text = ""
            self.nextStationLabel3.text = bShuttleStation[stationIndex+3].stationName
            self.nextStationLabel2.text = bShuttleStation[stationIndex+2].stationName
            self.nextStationLabel1.text = bShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = bShuttleStation[stationIndex-1].stationName
        } else if stationIndex == 0 {
            self.nextStationLabel4.text = bShuttleStation[stationIndex+4].stationName
            self.nextStationLabel3.text = bShuttleStation[stationIndex+3].stationName
            self.nextStationLabel2.text = bShuttleStation[stationIndex+2].stationName
            self.nextStationLabel1.text = bShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = ""
        } else {
            self.nextStationLabel4.text = bShuttleStation[stationIndex+4].stationName
            self.nextStationLabel3.text = bShuttleStation[stationIndex+3].stationName
            self.nextStationLabel2.text = bShuttleStation[stationIndex+2].stationName
            self.nextStationLabel1.text = bShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = bShuttleStation[stationIndex-1].stationName
        }
    }
}

extension BShuttleBusView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bShuttleStation.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ShuttleBusInfo", for: indexPath) as? ShuttleBusCollectionViewCell {

            if !bShuttleFirstTime.isEmpty {
                cell.setShuttleTime(fistTime: bShuttleFirstTime[indexPath.row], secondTime: bShuttleSecondTime[indexPath.row])
                cell.setStationImage(course: "B", stationIndex: indexPath.row)
            }

            return cell
        }

        return UICollectionViewCell()
    }
}

extension BShuttleBusView: UICollectionViewDelegate {
    //즐겨찾기 인텍스 부터 시작
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !onceOnly {
            let indexToScrollTo = IndexPath(item: bStationIndex!, section: 0)
            self.bShuttleBusCollectionView.scrollToItem(at: indexToScrollTo, at: .centeredHorizontally, animated: false)
            onceOnly = true
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        prevOffset = scrollView.contentOffset
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let currentOffset = targetContentOffset.pointee
        let visibleItemIndexPath = bShuttleBusCollectionView.indexPathsForVisibleItems
        var indexPath: IndexPath?

        if let prev = prevOffset {
            if prev.x <  currentOffset.x {
                if var max = visibleItemIndexPath.first {
                    for item in visibleItemIndexPath where item.row > max.row {
                        max = item
                    }
                    indexPath = max
                }
            } else {
                if var min = visibleItemIndexPath.first {
                    for item in visibleItemIndexPath where item.row < min.row {
                        min = item
                    }
                    indexPath = min
                }
            }
        }

        //index work
        if let index = indexPath?.row {
            setStationLabel(stationIndex: index)
            setStationLocation(stationIndex: index)
            setFavoriteButton(stationIndex: index)
        }

        self.currentIndex = indexPath?.row
    }
}
