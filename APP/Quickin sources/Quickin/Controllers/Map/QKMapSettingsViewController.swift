//
//  QKMapSettingsViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 01.09.2021.
//

import UIKit
import RangeSeekSlider

final class QKMapSettingsViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var applayButton: QKQuickinButton!
    @IBOutlet private weak var cancelButton: QKQuickinButton!

    @IBOutlet private var selectingControls: [QKPickValueControl]!
    @IBOutlet private weak var rangeControl: RangeSeekSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    private func updateUI() {
        
        let controlsNames: [String] = ["Город", "Округ", "Район", "Станция метро", "Категория"]
        
        selectingControls.forEach {
            guard let controlIndex = selectingControls.firstIndex(of: $0) else {
                return
            }

            $0.configure(
                header: nil,
                title: controlsNames[controlIndex],
                titleFont: UIFont.qkRegular(16),
                titleAligment: .left,
                leftIcon: nil,
                borderColor: UIColor.qkGray,
                action: { (control) in
                }
            )
            $0.setEnable(true, animation: false)
        }

//        rangeControl.configure(
//            currentStartValue: 0,
//            currentFinishValue: 0,
//            maxValue: 100,
//            delegate: self
//        )
        
        applayButton.configure(
            style: .background,
            title: "Применить",
            fontSize: 16,
            icon: UIImage(named: "ic_check_circle"),
            iconPosition: .left,
            action: { [weak self] (button) in
                self?.dismiss(animated: true, completion: nil)
            }
        )

        cancelButton.configure(
            style: .clear,
            title: "Отменить",
            fontSize: 16,
            icon: UIImage(named: "ic_xCircle"),
            iconPosition: .left,
            action: { [weak self] (button) in
                self?.dismiss(animated: true, completion: nil)
            }
        )

    }

}

//extension QKMapSettingsViewController: QKRangeControlDelegate {
//
//    func didChangeStartValue(_ value: Int) {
////        print("********* \(value)")
//    }
//
//    func didChangeFinishValue(_ value: Int) {
////        print("========= \(value)")
//    }
//
//}
