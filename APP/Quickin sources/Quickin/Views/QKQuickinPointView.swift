//
//  QKQuickinPointView.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit

final class QKQuickinPointView: UIView {
    
    @IBOutlet private weak var pickupPointNameLabel: UILabel!
    @IBOutlet private weak var pickupPointAddressLabel: UILabel!
    
    @IBOutlet private weak var authorizationCaptionLabel: UILabel!
    
    @IBOutlet private weak var scheduleDaysLabel: UILabel!
    @IBOutlet private weak var scheduleTimesLabel: UILabel!

    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var onMapButton: UIButton!
    private var onMapAction: Closure1<QKQuickinPointModel?>?
    private var confirmAction: Closure1<QKQuickinPointModel>?
    
    private var pickupPointModel: QKQuickinPointModel?

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    // MARK: UI
    private func setupUI() {
        self.fromNib()
        
        confirmButton.setTitle("Подключится", for: .normal)
        confirmButton.addCorners(cornerRadius: 2)
        
        onMapButton.setTitle("Маршрут", for: .normal)
        onMapButton.addBorder(
            width: 1,
            color: UIColor.qkGray.cgColor,
            cornerRadius: 2.0
        )
    }
    
    // MARK: user interactions
    @IBAction func onConfirm(_ sender: Any) {
        pickupPointModel.map { confirmAction?($0) }
    }
    
    @IBAction func onMap(_ sender: Any) {
        pickupPointModel.map { onMapAction?($0) }
    }

    func fill(
        with pickupPointModel: QKQuickinPointModel?,
        confirmAction: Closure1<QKQuickinPointModel>?,
        authorizationInfoAction: Closure1<QKQuickinPointModel>?,
        onMapAction: Closure1<QKQuickinPointModel?>?
    ) {
        var pickupPointModel = pickupPointModel
        scheduleDaysLabel.text = pickupPointModel?.scheduleData.day
        scheduleTimesLabel.text = pickupPointModel?.scheduleData.time
        pickupPointNameLabel.text = pickupPointModel?.name
        pickupPointAddressLabel.text = pickupPointModel?.addressString
        
        authorizationCaptionLabel.text = pickupPointModel?.type.description
        
        self.confirmAction = confirmAction
        self.pickupPointModel = pickupPointModel
        
        self.onMapAction = onMapAction
    }

}
