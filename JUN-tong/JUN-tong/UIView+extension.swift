//
//  UIView+extension.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2018. 3. 25..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit

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
