//
//  UIColor+extention.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 6..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

extension UIColor {
    func getBusCgColor(busType: Int) -> CGColor{
        let redBus = UIColor(red: 249.0/255.0, green: 60.0/255.0, blue: 69.0/255.0, alpha: 1.0)
        let blueBus = UIColor(red: 55.0/255.0, green: 77.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        let greenBus = UIColor(red: 114.0/255.0, green: 197.0/255.0, blue: 173.0/255.0, alpha: 1.0)
        
        switch busType {
        case 2:
            return redBus.cgColor
        case 3:
            return blueBus.cgColor
        case 4:
            return greenBus.cgColor
        default:
            return redBus.cgColor
        }
    }
}
