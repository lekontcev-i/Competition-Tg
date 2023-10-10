//
//  QKTutorialThirdViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

final class QKTutorialThirdViewController: UIViewController {
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    private func updateUI() {
    }

    // MARK: - Action
    
    func closeTutorial() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func didPressCloseButton(_ sender: Any) {
        closeTutorial()
    }
}

// MARK: - QKTutorialFlippingProtocol

extension QKTutorialThirdViewController: QKTutorialFlippingProtocol {

    func nextAction() {
        closeTutorial()
    }

}
