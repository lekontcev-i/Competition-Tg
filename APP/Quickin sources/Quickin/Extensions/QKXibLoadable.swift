//
//  QKXibLoadable.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit
 
protocol QKXibLoadable: AnyObject {
    var contentView: UIView? { get set }
    func setupXib(_ frame: CGRect)
}

extension QKXibLoadable where Self: UIView {
    
    func setupXib(_ frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let nibView = (nib.instantiate(withOwner: self, options: nil)[0] as? UIView) else { return }
        addSubview(nibView)
        
        nibView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nibView.leftAnchor.constraint(equalTo: self.leftAnchor),
            nibView.rightAnchor.constraint(equalTo: self.rightAnchor),
            nibView.topAnchor.constraint(equalTo: self.topAnchor),
            nibView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        addSubview(nibView)
        contentView = nibView
    }
    
}
