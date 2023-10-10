//
//  QKOrangeButton.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

enum QKButtonStyle {
    case background
    case clear
}

enum QKButtonState {
    case normal
    case hover
    case disable
}

enum QKIconAlignment {
    case left
    case right
}

final class QKQuickinButton: QKContainerView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var actionButton: QKHighlightedButton!
    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var rightImageView: UIImageView!

    private var action: Closure1<QKQuickinButton>?
    
    private var style: QKButtonStyle = .background {
        didSet {
            switch style {
            case .background:
                setBackgroundStyle()
            case .clear:
                setClearStyle()
            }
        }
    }
    
    private var state: QKButtonState = .normal {
        didSet {
            switch style {
            case .background:
                switch state {
                case .normal:
                    setBackgroundStyle()
                case .hover:
                    setClearStyle()
                case .disable:
                    setDisableStyle()
                }
            case .clear:
                switch state {
                case .normal:
                    setClearStyle()
                case .hover:
                    setBackgroundStyle()
                case .disable:
                    setDisableStyle()
                }
            }
        }
    }
    
    private var normalTitleColor: UIColor = .white
    private var hoverTitleColor: UIColor = .qkDarkOrange
    private var disableTitleColor: UIColor = .white

    private var normalBackgroundColor: UIColor = .qkOrange {
        didSet {
            addBorder(color: normalBackgroundColor.cgColor)
        }
    }
    private var hoverBackgroundColor: UIColor = .clear
    private var disableBackgroundColor: UIColor = .qkLightYellow

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setRounded()
        addBorder(color: UIColor.qkOrange.cgColor)
        
        actionButton.highlightingHandler = { [weak self] (isHighlighted) in
            self?.state = isHighlighted ? .hover : .normal
        }
    }
    
    override func setup() {
    }
    
    // MARK: - Private Methods

    private func setBackgroundStyle() {
        contentView.backgroundColor = normalBackgroundColor
        titleLabel.textColor = normalTitleColor
        leftImageView.tintColor = normalTitleColor
        rightImageView.tintColor = normalTitleColor
    }
    
    private func setClearStyle() {
        contentView.backgroundColor = hoverBackgroundColor
        titleLabel.textColor = hoverTitleColor
        leftImageView.tintColor = hoverTitleColor
        rightImageView.tintColor = hoverTitleColor
    }

    private func setDisableStyle() {
        contentView.backgroundColor = disableBackgroundColor
        titleLabel.textColor = disableTitleColor
        leftImageView.tintColor = disableTitleColor
        rightImageView.tintColor = disableTitleColor
    }

    // MARK: - Public Methods
    
    func configure(
        style: QKButtonStyle,
        title: String,
        fontSize: CGFloat,
        icon: UIImage?,
        iconPosition: QKIconAlignment,
        action: @escaping Closure1<QKQuickinButton>
    ) {
        self.action = action

        self.style = style
        
        titleLabel.font = UIFont.qkSemiBold(ofSize: fontSize)
        titleLabel.text = title
        
        switch iconPosition {
        case .left:
            rightImageView.isHidden = true
            leftImageView.image = icon
        case .right:
            leftImageView.isHidden = true
            rightImageView.image = icon
        }
    }
    
    func setBackgroundColor(color: UIColor, forState state: QKButtonState) {
        
        switch state {
        case .normal:
            normalBackgroundColor = color
        case .hover:
            hoverBackgroundColor = color
        case .disable:
            disableBackgroundColor = color
        }
        
        switch style {
        case .background:
            setBackgroundStyle()
        case .clear:
            setClearStyle()
        }
    }
    
    func setTitleColor(color: UIColor, forState state: QKButtonState) {
        
        switch state {
        case .normal:
            normalTitleColor = color
        case .hover:
            hoverTitleColor = color
        case .disable:
            disableTitleColor = color
        }
        
        switch style {
        case .background:
            setBackgroundStyle()
        case .clear:
            setClearStyle()
        }
    }

    // MARK: - IBActions

    @IBAction func didPressActionButton(_ sender: UIButton) {
        action?(self)
    }
    
}
