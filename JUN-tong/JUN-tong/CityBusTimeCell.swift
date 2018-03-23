//
//  CityBusTimeCell.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 10. 4..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit
import UserNotifications

class CityBusTimeCell: UITableViewCell {

    @IBOutlet weak var departTimeLabel: UILabel!
    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var cityBusTimeCell: UIView!
    @IBOutlet var cityBusAlarmButton: UIButton!

    func setCustone(departTime: String, reaminTime: Int, cellColor: UIColor) {
        departTimeLabel.text = departTime
        remainTimeLabel.text = "\(reaminTime)분전"
        cityBusTimeCell.backgroundColor = cellColor.withAlphaComponent(0.1)
    }

    @IBAction func cityBusAlarmButtonTap(_ sender: Any) {
        let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
        if isRegisteredForRemoteNotifications {

        } else {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge],
                                                                    completionHandler: {didAllow, error in
                                                                        if didAllow {
                                                                            print("allow")
                                                                        } else {
                                                                            let alert = UIAlertController(title: "알람 설정 필요",
                                                                                                          message: "알람을 받기 위해서는 알람 설정이 필요합니다.\n알람 설정은 '설정'탭에서 확인할 수 있습니다.", preferredStyle: .alert)
                                                                            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                                                                            alert.addAction(ok)
                                                                            self.parentViewController?.present(alert, animated: true, completion: nil)
                                                                        }
            })
        }
    }

    private func alarmResister() {

    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
