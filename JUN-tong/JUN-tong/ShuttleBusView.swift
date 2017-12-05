//
//  ShuttleBusView.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 27..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class ShuttleBusView: UIViewController {

    @IBOutlet weak var shuttleBusCollectionView: UICollectionView!

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
    var aStationIndex: Int?
    var currentIndex: Int?
    var aShuttleFirstTime: [Int] = []
    var aShuttleSecondTime: [Int] = []
    var onceOnly = false

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(setShuttleIndex),
                                               name: NSNotification.Name(rawValue: "setAShuttleIndex"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setShuttleTime),
                                               name: NSNotification.Name(rawValue: "setAShuttelTime"), object: nil)

        view.addSubview(shuttleBusCollectionView)

        shuttleBusCollectionView.dataSource = self
        shuttleBusCollectionView.delegate = self

        shuttleBusCollectionView.register(UINib(nibName: "ShuttleBusInfo", bundle: nil), forCellWithReuseIdentifier: "ShuttleBusInfo")
        setCollectionViewLayout()
    }

    @IBAction func favoriteButtionClick(_ sender: Any) {
        UserDefaults.standard.set(aShuttleStation[currentIndex!].stationName, forKey: "mainStation")
        aStationIndex = currentIndex
        setFavoriteButton(stationIndex: aStationIndex!)
        shuttleBusController.setShuttleBusIndex(shuttleBusName: aShuttleStation[aStationIndex!].stationName)
    }

    @objc func setShuttleIndex(_ notification: Notification) {
        aStationIndex = notification.userInfo!["aShuttleIndex"] as? Int
        currentIndex = aStationIndex
        if let stationIndex = aStationIndex {
            setStationLabel(stationIndex: stationIndex)
            setFavoriteButton(stationIndex: stationIndex)
            setStationLocation(stationIndex: stationIndex)
        }
    }

    @objc func setShuttleTime(_ notification: Notification) {
        if let aShuttleFirstTime = notification.userInfo!["ashuttleFirstTime"] as? [Int] {
            self.aShuttleFirstTime = aShuttleFirstTime
        }
        if let aShuttleSecondTime = notification.userInfo!["ashuttleSecondTime"] as? [Int] {
            self.aShuttleSecondTime = aShuttleSecondTime
        }
        shuttleBusCollectionView.reloadData()
    }

    func setFavoriteButton(stationIndex: Int) {
        if aStationIndex == stationIndex {
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

        shuttleBusCollectionView.collectionViewLayout = layout
        shuttleBusCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }

    func setStationLabel(stationIndex: Int) {
        if stationIndex == 0 {
            self.leftStationLabel.isHidden = true
            self.centerStationLabel.text = aShuttleStation[stationIndex].stationName
            self.rightStationLabel.text = aShuttleStation[stationIndex+1].stationName
        } else if stationIndex == aShuttleStation.count-1 {
            self.leftStationLabel.text = aShuttleStation[stationIndex-1].stationName
            self.centerStationLabel.text = aShuttleStation[stationIndex].stationName
            self.rightStationLabel.isHidden = true
        } else {
            self.rightStationLabel.isHidden = false
            self.leftStationLabel.isHidden = false
            self.leftStationLabel.text = aShuttleStation[stationIndex-1].stationName
            self.centerStationLabel.text = aShuttleStation[stationIndex].stationName
            self.rightStationLabel.text = aShuttleStation[stationIndex+1].stationName
        }
    }

    func setStationLocation(stationIndex: Int) {
        if stationIndex == aShuttleStation.count-1 {
            self.nextStationLabel4.text = ""
            self.nextStationLabel3.text = ""
            self.nextStationLabel2.text = ""
            self.nextStationLabel1.text = ""
            self.previousStationLabel.text = aShuttleStation[stationIndex-1].stationName
        } else if stationIndex == aShuttleStation.count-2 {
            self.nextStationLabel4.text = ""
            self.nextStationLabel3.text = ""
            self.nextStationLabel2.text = ""
            self.nextStationLabel1.text = aShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = aShuttleStation[stationIndex-1].stationName
        } else if stationIndex == aShuttleStation.count-3 {
            self.nextStationLabel4.text = ""
            self.nextStationLabel3.text = ""
            self.nextStationLabel2.text = aShuttleStation[stationIndex+2].stationName
            self.nextStationLabel1.text = aShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = aShuttleStation[stationIndex-1].stationName
        } else if stationIndex == aShuttleStation.count-4 {
            self.nextStationLabel4.text = ""
            self.nextStationLabel3.text = aShuttleStation[stationIndex+3].stationName
            self.nextStationLabel2.text = aShuttleStation[stationIndex+2].stationName
            self.nextStationLabel1.text = aShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = aShuttleStation[stationIndex-1].stationName
        } else if stationIndex == 0 {
            self.nextStationLabel4.text = aShuttleStation[stationIndex+4].stationName
            self.nextStationLabel3.text = aShuttleStation[stationIndex+3].stationName
            self.nextStationLabel2.text = aShuttleStation[stationIndex+2].stationName
            self.nextStationLabel1.text = aShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = ""
        } else {
            self.nextStationLabel4.text = aShuttleStation[stationIndex+4].stationName
            self.nextStationLabel3.text = aShuttleStation[stationIndex+3].stationName
            self.nextStationLabel2.text = aShuttleStation[stationIndex+2].stationName
            self.nextStationLabel1.text = aShuttleStation[stationIndex+1].stationName
            self.previousStationLabel.text = aShuttleStation[stationIndex-1].stationName
        }
    }
}

extension ShuttleBusView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aShuttleStation.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ShuttleBusInfo", for: indexPath) as? ShuttleBusCollectionViewCell {

            if !aShuttleFirstTime.isEmpty {
                cell.setShuttleTime(fistTime: aShuttleFirstTime[indexPath.row], secondTime: aShuttleSecondTime[indexPath.row])
                cell.setStationImage(course: "A", stationIndex: indexPath.row)
            }

            return cell
        }

        return UICollectionViewCell()
    }
}

extension ShuttleBusView: UICollectionViewDelegate {
    //즐겨찾기 인텍스 부터 시작
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !onceOnly {
            let indexToScrollTo = IndexPath(item: aStationIndex!, section: 0)
            self.shuttleBusCollectionView.scrollToItem(at: indexToScrollTo, at: .centeredHorizontally, animated: false)
            onceOnly = true
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        prevOffset = scrollView.contentOffset
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let currentOffset = targetContentOffset.pointee
        let visibleItemIndexPath = shuttleBusCollectionView.indexPathsForVisibleItems
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

class ShuttleBusCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        if let cv = self.collectionView {

            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth + 5

            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                var candidateAttributes: UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {

                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }

                    if let candAttrs = candidateAttributes {
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttrs.center.x - proposedContentOffsetCenterX

                        if fabsf(Float(a)) < fabsf(Float(b)) {
                            candidateAttributes = attributes
                        }

                    } else { // == First time in the loop == //
                        candidateAttributes = attributes
                        continue
                    }
                }

                return CGPoint(x : candidateAttributes!.center.x - halfWidth, y : proposedContentOffset.y)
            }
        }
        // Fallback
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
}
