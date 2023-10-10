//
//  QKTutorialViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 28.08.2021.
//

import UIKit

protocol QKTutorialFlippingProtocol {
    func nextAction()
}

final class QKTutorialViewController: UIViewController {
    
    @IBOutlet private weak var nextButton: QKQuickinButton!
    @IBOutlet weak var containerView: UIView!
    
    var embedViewController: UINavigationController?
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    private func updateUI() {
        
        nextButton.configure(
            style: .background,
            title: "Дальше",
            fontSize: 20,
            icon: UIImage(named: "ic_arrowRight"),
            iconPosition: .right,
            action: { [weak self] (button) in
                if let topViewController = self?.embedViewController?.topViewController as? QKTutorialFlippingProtocol {
                    topViewController.nextAction()
                }
            }
        )
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let navigationController = segue.destination as? UINavigationController {
            embedViewController = navigationController
        }
    }

}

