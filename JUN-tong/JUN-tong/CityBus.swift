//
//  CityBus.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 1..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation


struct CityBus {
    private var _lineNo: String
    private var _description: String
    private var _lineId: String
    private var _firstBusTime: Int?
    private var _secondBusTime: Int?
    
    init(lineNo: String, description: String, lineId: String, firstBusTime: Int?, secondBusTime: Int?) {
        self._lineNo = lineNo
        self._description = description
        self._lineId = lineId
        self._firstBusTime = firstBusTime
        self._secondBusTime = secondBusTime
    }
    
    public var lineNo: String {
        get { return self._lineNo}
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
