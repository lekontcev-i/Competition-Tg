//
//  UIView+Constraints.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

extension UIView {
    
    func addSubviewWithConstraints(subview: UIView, _ constraints: UIEdgeInsets = .zero) {
        
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constraints.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constraints.right),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: constraints.top),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constraints.bottom)
        ])
    }
 
    func edges(to view: UIView, left:CGFloat = 0, right:CGFloat = 0, top:CGFloat = 0, bottom:CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
        ])
    }

}
