//
//  UIView+Rotation.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit

extension UIView {
    
    func startRotation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = NSNumber(value: Double.pi)
        rotation.duration = 0.5
        rotation.isCumulative = true
        rotation.repeatCount = Float.infinity
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopRotation() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
}
