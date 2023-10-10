//
//  QKSettingButton.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 02.09.2021.
//

import UIKit

final class QKSettingButton: QKContainerView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var iconImageView: UIImageView!

    private var action: Closure1<QKSettingButton>?

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setup() {
    }

    // MARK: - Public Methods
    
    func configure(
        title: String,
        icon: UIImage?,
        action: @escaping Closure1<QKSettingButton>
    ) {
        self.action = action

        titleLabel.text = title
        iconImageView.image = icon
    }
    
    // MARK: - IBActions

    @IBAction func didPressActionButton(_ sender: UIButton) {
        action?(self)
    }

}
