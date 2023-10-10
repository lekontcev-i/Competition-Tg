//
//  QKChangeValueControl.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 07.09.2021.
//

import UIKit

final class QKChangeValueControl: QKContainerView {
    
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet weak var editIcon: UIImageView!

    @IBOutlet private weak var controlView: UIView!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!

    private(set) var isEnabled: Bool = false
    private(set) var needConfirm: Bool = false

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
        textValue: String,
        fieldFont: UIFont,
        borderColor: UIColor,
        needConfirm: Bool
    ) {
        controlView.addBorder(color: borderColor.cgColor)

        headerView.isHidden = header == nil
        headerLabel.text = header
        
        valueTextField.font = fieldFont
        valueTextField.text = textValue

        self.needConfirm = needConfirm
        confirmButton.isHidden = !needConfirm

        setEnable(false, animation: false)
    }

    func setEnable(_ isEnabled: Bool, animation: Bool) {
        
        self.isEnabled = isEnabled
        
        valueTextField.isEnabled = isEnabled

        guard animation else {
            editIcon.isHidden = !isEnabled
            confirmButton.isHidden = needConfirm ? !isEnabled : true
            return
        }
        
        if isEnabled {
            editIcon.alpha = 0
            editIcon.isHidden = false
        }

        UIView.animate(withDuration: 0.2) {
            
            self.editIcon.alpha = isEnabled ? 1 : 0

            if isEnabled {
                self.confirmButton.isHidden = self.needConfirm ? false : true
            } else {
            }
            
        } completion: { finish in
            
            if finish {
                UIView.animate(withDuration: 0.2) {
                    if isEnabled {
                    } else {
                        self.confirmButton.isHidden = true
                        self.editIcon.isHidden = true
                    }
                }
            }
        }
    }

    // MARK: - IBActions
    
    @IBAction func didPressConfirmButton(_ sender: Any) {
    }

}

extension QKChangeValueControl: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
