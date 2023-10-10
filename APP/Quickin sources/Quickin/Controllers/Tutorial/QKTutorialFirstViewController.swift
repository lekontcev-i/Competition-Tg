//
//  QKTutorialFirstViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

final class QKTutorialFirstViewController: UIViewController {
    
    private let secondTotorialSegueId = "QKSecondTotorialSegueId"

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func updateUI() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let tutorialSecondViewController = segue.destination as? QKTutorialSecondViewController {
            
        }
    }

}

// MARK: - QKTutorialFlippingProtocol

extension QKTutorialFirstViewController: QKTutorialFlippingProtocol {

    func nextAction() {
        performSegue(withIdentifier: secondTotorialSegueId, sender: nil)
    }

}
