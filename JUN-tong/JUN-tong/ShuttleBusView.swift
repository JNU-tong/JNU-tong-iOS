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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shuttleBusCollectionView)
        
        shuttleBusCollectionView.dataSource = self
        shuttleBusCollectionView.delegate = self
        
        shuttleBusCollectionView.register(UINib(nibName: "ShuttleBusInfo", bundle: nil), forCellWithReuseIdentifier: "ShuttleBusInfo")
    }
}

extension ShuttleBusView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ShuttleBusInfo", for: indexPath) as? ShuttleBusCollectionViewCell {
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension ShuttleBusView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width - (15 + 7.5), height: (self.view.bounds.height / 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }
}
