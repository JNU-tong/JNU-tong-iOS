//
//  ShuttleBusDetailViewController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 27..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//
import UIKit

class ShuttleBusDetailViewController: UIViewController {
   
    @IBOutlet weak var ABusStatus: UIView!
    @IBOutlet weak var BBusStatus: UIView!
    
    @IBOutlet weak var ABusButtonOutlet: UIButton!
    @IBOutlet weak var BBusButtonOutlet: UIButton!
    
    @IBOutlet weak var ABusContainerView: UIView!
    @IBOutlet weak var BBusContainerView: UIView!
    
    let shuttleBusController = ShuttleBusController()
    var mainStation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //A버스 부터 시작
        BBusStatus.isHidden = true
        BBusButtonOutlet.setTitleColor(.gray, for: .normal)
        self.BBusContainerView.alpha = 0
        self.ABusContainerView.alpha = 1
        
        shuttleBusController.setShuttleBusIndex(shuttleBusName: mainStation!)
    }
    
    @IBAction func ABusTab(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.BBusContainerView.alpha = 0
            self.ABusContainerView.alpha = 1
        })
        self.BBusStatus.isHidden = true
        self.BBusButtonOutlet.setTitleColor(.gray, for: .normal)
        
        self.ABusStatus.isHidden = false
        self.ABusButtonOutlet.setTitleColor(UIColor.init(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1), for: .normal)
    }
    
    @IBAction func BBusTab(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.ABusContainerView.alpha = 0
            self.BBusContainerView.alpha = 1
        })
        self.ABusStatus.isHidden = true
        self.ABusButtonOutlet.setTitleColor(.gray, for: .normal)
        
        self.BBusStatus.isHidden = false
        self.BBusButtonOutlet.setTitleColor(UIColor.init(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1), for: .normal)
    }
}
