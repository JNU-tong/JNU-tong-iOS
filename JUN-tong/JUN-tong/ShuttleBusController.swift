//
//  ShuttleBusController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 31..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import Foundation


class ShuttleBusController {
    let AshuttleStation = ["정문", "제2도서관", "해대서쪽", "본관", "학생회관", "인대서쪽", "생활관", "인대동쪽", "도서관", "의전원", "공대4호관", "해대4호관", "교양동", "해대서쪽", "제2도서관", "정문"]
    let BshuttleStation = ["정문", "제2도서관", "해대서쪽", "교양동", "해대4호관", "공대4호관", "의전원", "도서관", "인대동쪽", "생활관", "인대서쪽", "학생회관", "본관", "해대서쪽", "제2도서관", "정문"]
    var mainStation = "정문"
    
    func setMainStation() {
        if UserDefaults.standard.object(forKey: "mainStation") != nil {
            mainStation = UserDefaults.standard.string(forKey: "mainStation")!
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "mainShuttleBusSet"), object: nil, userInfo: ["mainStation": mainStation])
    }
}
