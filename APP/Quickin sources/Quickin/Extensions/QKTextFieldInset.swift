//
//  QKTextFieldInset.swift
//  SmartWiFiDemoApp
//
//  Created by Vitaliy Pedan on 13.08.2021.
//

import UIKit

class QKTextFieldInset: UITextField {
    @IBInspectable var insetX: CGFloat = 15 {
       didSet {
         layoutIfNeeded()
       }
    }
    @IBInspectable var insetY: CGFloat = 0 {
       didSet {
         layoutIfNeeded()
       }
    }

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - 45, y: 0, width: 40, height: bounds.size.height)
    }
}
