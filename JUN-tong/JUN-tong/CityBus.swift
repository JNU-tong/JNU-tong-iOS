//
//  CityBus.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 1..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation
import UIKit


struct CityBus {
    private var _lineNo: String
    private var _description: String
    private var _lineId: String
    private var _firstBusTime: Int?
    private var _secondBusTime: Int?
    
    enum cityBusType: Int {
        case redBus = 2
        case blueBus = 3
        case greenBus = 4
        
        func getBusUIColor() -> UIColor {
            let redBus = UIColor(red: 249.0/255.0, green: 60.0/255.0, blue: 69.0/255.0, alpha: 1.0)
            let blueBus = UIColor(red: 55.0/255.0, green: 77.0/255.0, blue: 249.0/255.0, alpha: 1.0)
            let greenBus = UIColor(red: 114.0/255.0, green: 197.0/255.0, blue: 173.0/255.0, alpha: 1.0)
            
            switch self {
            case .redBus:
                return redBus
            case .blueBus:
                return blueBus
            case .greenBus:
                return greenBus
            }
        }
    }
    
    init(lineNo: String, description: String, lineId: String, firstBusTime: Int?, secondBusTime: Int?) {
        self._lineNo = lineNo
        self._description = description
        self._lineId = lineId
        self._firstBusTime = firstBusTime
        self._secondBusTime = secondBusTime
    }
    
    public var cityBusColor: UIColor {
        get {
            let busType = cityBusType(rawValue: Int(String(Array(lineNo)[0]))!)
            return busType!.getBusUIColor()
        }
    }

    public var lineNo: String {
        get { return self._lineNo }
        set { self._lineNo = newValue }
    }
    
    public var description: String {
        get { return self._description }
        set { self._description = newValue }
    }
    
    public var lineId: String {
        get { return self._lineId }
        set { self._lineId = newValue }
    }
    
    public var firstBusTime: Int? {
        get {
            if self._firstBusTime != nil { return self._firstBusTime }
            else { return nil }
        }
        set { self._firstBusTime = newValue }
    }
    
    public var secondBusTime: Int? {
        get {
            if self._secondBusTime != nil { return self._secondBusTime }
            else { return nil }
        }
        set { self._secondBusTime = newValue }
    }
}
