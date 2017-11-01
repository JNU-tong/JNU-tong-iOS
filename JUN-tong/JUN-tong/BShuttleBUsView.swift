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
    
    
    let shuttleBusController = ShuttleBusController()
    var prevOffset: CGPoint?
    var bStationIndex: Int?
    var onceOnly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setShuttleIndex),
                                               name: NSNotification.Name(rawValue: "setBShuttleIndex"), object: nil)
        
        view.addSubview(bShuttleBusCollectionView)
        
        bShuttleBusCollectionView.dataSource = self
        bShuttleBusCollectionView.delegate = self
        
        bShuttleBusCollectionView.register(UINib(nibName: "ShuttleBusInfo", bundle: nil), forCellWithReuseIdentifier: "ShuttleBusInfo")
        setCollectionViewLayout()
    }
    
    @objc func setShuttleIndex(_ notification: Notification) {
        bStationIndex = notification.userInfo!["bShuttleIndex"] as? Int
        setStationLabel(stationIndex: bStationIndex!)
        setFavoriteButton(stationIndex: bStationIndex!)
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
        layout.itemSize = CGSize(width: self.view.bounds.width - 64 - 10, height: self.view.bounds.height/2)
        
        bShuttleBusCollectionView.collectionViewLayout = layout
        bShuttleBusCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    func setStationLabel(stationIndex: Int) {
        if stationIndex == 0 {
            self.leftStationLabel.isHidden = true
            self.centerStationLabel.text = BshuttleStation[stationIndex]
            self.rightStationLabel.text = BshuttleStation[stationIndex+1]
        } else if stationIndex == BshuttleStation.count-1 {
            self.leftStationLabel.text = BshuttleStation[stationIndex-1]
            self.centerStationLabel.text = BshuttleStation[stationIndex]
            self.rightStationLabel.isHidden = true
        } else {
            self.rightStationLabel.isHidden = false
            self.leftStationLabel.isHidden = false
            self.leftStationLabel.text = BshuttleStation[stationIndex-1]
            self.centerStationLabel.text = BshuttleStation[stationIndex]
            self.rightStationLabel.text = BshuttleStation[stationIndex+1]
        }
    }
}

extension BShuttleBusView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AshuttleStation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ShuttleBusInfo", for: indexPath) as? ShuttleBusCollectionViewCell {
            
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
        
        setStationLabel(stationIndex: (indexPath?.row)!)
        setFavoriteButton(stationIndex: (indexPath?.row)!)
    }
}
