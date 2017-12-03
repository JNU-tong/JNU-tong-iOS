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

    enum CityBusType: Int {
        case nightBus = 1
        case busOf200 = 2
        case busOf300 = 3
        case busOf400 = 4

        func getBusUIColor() -> UIColor {
            let nightBusColor = UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 114.0/255.0, alpha: 1.0)
            let blueBusColor = UIColor(red: 49.0/255.0, green: 183.0/255.0, blue: 227.0/255.0, alpha: 1.0)
            let greenBusColor = UIColor(red: 114.0/255.0, green: 197.0/255.0, blue: 173.0/255.0, alpha: 1.0)

            switch self {
            case .nightBus:
                return nightBusColor
            case .busOf200:
                return blueBusColor
            case .busOf300:
                return blueBusColor
            case .busOf400:
                return greenBusColor
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

    public var cityBusType: CityBusType {
        var busType: CityBusType?

        if Int(lineNo) == 3003 {
            busType = CityBusType(rawValue: 1)
        } else {
            busType = CityBusType(rawValue: Int(String(Array(lineNo)[0]))!)
        }
        return busType!
    }

    public var cityBusColor: UIColor {
        var busType: CityBusType?

        if Int(lineNo) == 3003 {
            busType = CityBusType(rawValue: 1)
        } else {
            busType = CityBusType(rawValue: Int(String(Array(lineNo)[0]))!)
        }

        return busType!.getBusUIColor()
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
            if self._firstBusTime != nil {
                return self._firstBusTime
            } else {
                return nil
            }
        }
        set { self._firstBusTime = newValue }
    }

    public var secondBusTime: Int? {
        get {
            if self._secondBusTime != nil {
                return self._secondBusTime
            } else {
                return nil
            }
        }
        set { self._secondBusTime = newValue }
    }
}
