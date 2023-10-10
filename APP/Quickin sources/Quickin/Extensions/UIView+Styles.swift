//
//  UIView+Styles.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

extension UIView {

    func addBorder(color: CGColor) {
        layer.masksToBounds = true
        layer.borderColor = color
        layer.borderWidth = 1.0
    }
    
    func addCorners(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }

    func addBorder(
        width: CGFloat = 1.0,
        color: CGColor,
        cornerRadius: CGFloat
    ) {
        layer.masksToBounds = true
        layer.borderColor = color
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
    }

    func setRounded() {
        addCorners(cornerRadius: min(frame.width, frame.height) * 0.5)
    }

    func animatedShow() {
        alpha = 0.0
        isHidden = false
        
        UIView.animate(
            withDuration: 0.2,
            animations: { [weak self] in
                self?.alpha = 1.0
            },
            completion: nil
        )
    }
    
    func animatedHide(completion: Closure? = nil) {
        alpha = 1.0
        isHidden = false
        
        UIView.animate(
            withDuration: 0.2,
            animations: { [weak self] in
                self?.alpha = 0.0
            }
        )
        { [weak self] _ in
            self?.isHidden = true
            completion?()
        }
    }

}
