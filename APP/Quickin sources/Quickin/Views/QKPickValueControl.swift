//
//  QKPickValueControl.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 02.09.2021.
//

import UIKit

enum QKTitleAlignment {
    case left
    case center
    case right
}

final class QKPickValueControl: QKContainerView {

    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var controlView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!
    @IBOutlet private weak var leftIconImageView: UIImageView!
    @IBOutlet private weak var leftView: UIView!

    private(set) var isEnabled: Bool = true
    private var titleAlignment: QKTitleAlignment = .center

    private var action: Closure1<QKPickValueControl>?

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        controlView.setRounded()
    }
    
    override func setup() {
    }
    
    // MARK: - Public Methods
    
    func configure(
        header: String?,
        title: String,
        titleFont: UIFont,
        titleAligment: QKTitleAlignment,
        leftIcon: UIImage?,
        borderColor: UIColor,
        action: @escaping Closure1<QKPickValueControl>
    ) {
        self.action = action
        
        headerLabel.isHidden = header == nil
        headerLabel.text = header
        
        controlView.addBorder(color: borderColor.cgColor)

        leftView.isHidden = leftIcon == nil
        leftIconImageView.image = leftIcon
        
        titleLabel.font = titleFont
        titleLabel.text = title
        titleLabel.textAlignment = labelTextAligment(titleAligment: titleAligment)
        
        arrowImageView.tintColor = borderColor
        
        setEnable(false, animation: false)
    }

    func setEnable(_ isEnabled: Bool, animation: Bool) {
        
        self.isEnabled = isEnabled
        
        guard animation else {
            arrowImageView.isHidden = !isEnabled
            return
        }
        
        if isEnabled {
            arrowImageView.alpha = 0
        }
        
        UIView.animate(withDuration: 0.2) {
            if isEnabled {
                self.arrowImageView.isHidden = false
            } else {
                self.arrowImageView.alpha = 0
            }

        } completion: { finish in
            
            if finish {
                UIView.animate(withDuration: 0.2) {
                    if isEnabled {
                        self.arrowImageView.alpha = 1
                    } else {
                        self.arrowImageView.isHidden = true
                    }
                }
            }
        }
    }
    
    private func labelTextAligment(titleAligment: QKTitleAlignment) -> NSTextAlignment {
        switch titleAligment {
        case .left:
            return .left
        case .center:
            return .center
        case .right:
            return .right
        }
    }
    
    // MARK: - IBActions

    @IBAction func didPressControl(_ sender: Any) {
        guard isEnabled else {
            return
        }
        
        action?(self)
    }
    
}
