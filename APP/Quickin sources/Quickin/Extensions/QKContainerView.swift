//
//  QKContainerView.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

class QKContainerView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupContainer()
        setup()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupContainer()
        setup()
    }
    
    private func setupContainer() {
        
        backgroundColor = .clear
        let string = String(describing: Self.self)
        guard let view = Bundle.main.loadNibNamed(string, owner: self, options: nil)?.first as? UIView else {
            return
        }
        addSubviewWithConstraints(subview: view)
    }
    
    func setup() {
        // overridable
    }
}
