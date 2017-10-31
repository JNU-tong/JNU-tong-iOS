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
    @IBOutlet weak var righyStationLabel: UILabel!
    
    var prevOffset: CGPoint?
    var aStationIndex: Int?
    var onceOnly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setShuttleIndex),
                                               name: NSNotification.Name(rawValue: "setAShuttleIndex"), object: nil)
        
        view.addSubview(shuttleBusCollectionView)
        
        shuttleBusCollectionView.dataSource = self
        shuttleBusCollectionView.delegate = self
        
        shuttleBusCollectionView.register(UINib(nibName: "ShuttleBusInfo", bundle: nil), forCellWithReuseIdentifier: "ShuttleBusInfo")
        setCollectionViewLayout()
    }
    
    @objc func setShuttleIndex(_ notification: Notification) {
        aStationIndex = notification.userInfo!["aShuttleIndex"] as! Int
    }
    
    func setCollectionViewLayout() {
        let layout = ShuttleBusCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        layout.itemSize = CGSize(width: self.view.bounds.width - 64 - 10, height: self.view.bounds.height/2)
        
        shuttleBusCollectionView.collectionViewLayout = layout
        shuttleBusCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    func setStationLabel(stationIndex: Int) {
        
    }
}

extension ShuttleBusView: UICollectionViewDataSource {
    
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
