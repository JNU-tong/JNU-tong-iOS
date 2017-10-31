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
        BBusContainerView.isHidden = true
        
        shuttleBusController.setShuttleBusIndex(shuttleBusName: mainStation!)
    }
    
    @IBAction func ABusTab(_ sender: Any) {
        BBusContainerView.isHidden = true
        BBusStatus.isHidden = true
        BBusButtonOutlet.setTitleColor(.gray, for: .normal)
        
        ABusContainerView.isHidden = false
        ABusStatus.isHidden = false
        ABusButtonOutlet.setTitleColor(UIColor.init(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1), for: .normal)
    }
    
    @IBAction func BBusTab(_ sender: Any) {
        ABusContainerView.isHidden = true
        ABusStatus.isHidden = true
        ABusButtonOutlet.setTitleColor(.gray, for: .normal)
        
        BBusContainerView.isHidden = false
        BBusStatus.isHidden = false
        BBusButtonOutlet.setTitleColor(UIColor.init(red: CGFloat(0.0 / 255.0), green: CGFloat(44.0 / 255.0), blue: CGFloat(65.0 / 255.0), alpha: 1), for: .normal)
    }
}
