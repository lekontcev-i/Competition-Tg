//
//  UIView+Nib.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit

extension UIView {
    public class func fromXib() -> Self {
        return fromXib(viewType: self)
    }
    
    private class func fromXib <T: UIView>(viewType: T.Type) -> T {
        let nibName = String(describing: T.self)
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? T ?? T()
    }
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        let nibName = String(describing: type(of: self))
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(nibName,
                                                                         owner: self,
                                                                         options: nil)?.first as? T
        else {
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.edges(to: self)
        return contentView
    }
}
