//
//  QKSafeAreaSize.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit

struct QKSafeAreaDistance {
    let topPadding: CGFloat
    let bottomPadding: CGFloat
}

final class QKSafeArea {
    
    static var distance: QKSafeAreaDistance {
        var topPadding:    CGFloat = 0
        var bottomPadding: CGFloat = 0
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = window?.safeAreaInsets.bottom ?? 0
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        
        return QKSafeAreaDistance(topPadding: topPadding, bottomPadding: bottomPadding)
    }
}
