//
//  QKHighlightedButton.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

class QKHighlightedButton: UIButton {

    var highlightingHandler: ((Bool) -> Void)?
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted != oldValue {
                highlightingHandler?(isHighlighted)
            }
        }
    }
    
}
