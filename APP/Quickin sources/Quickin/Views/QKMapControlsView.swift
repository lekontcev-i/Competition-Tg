//
//  QKMapControlsView.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit

protocol QKMapControlsDelegate: AnyObject {
    func plusButtonDidTap()
    func minusButtonDidTap()
    func locationButtonDidTap()
}

final class QKMapControlsView: QKContainerView {

    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    
    weak var delegate: QKMapControlsDelegate?
    
    // MARK: - UI
    
    override func setup() {
        buttons.forEach {
            $0.setRounded()
            $0.addBorder(color: UIColor.qkGray.cgColor)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func plusButtonDidTap(_ sender: UIButton) {
        delegate?.plusButtonDidTap()
    }
    
    @IBAction func minusButtonDidTap(_ sender: UIButton) {
        delegate?.minusButtonDidTap()
    }
    
    @IBAction func locationButtonDidTap(_ sender: UIButton) {
        delegate?.locationButtonDidTap()
    }
}
