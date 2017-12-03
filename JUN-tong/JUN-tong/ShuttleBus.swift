//
//  ShuttleBus.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 12. 3..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation
import UIKit

struct ShuttleBus {
    private var _stationName: String
    private var _stationImage: UIImage

    init(stationName: String, stationImage: UIImage) {
        self._stationName = stationName
        self._stationImage = stationImage
    }

    public var stationName: String {
        get { return self._stationName }
        set { self._stationName = newValue}
    }

    public var stationImage: UIImage {
        get { return self._stationImage }
        set { self._stationImage = newValue }
    }
}
