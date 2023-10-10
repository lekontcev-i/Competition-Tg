//
//  QKTutorialSecondViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

final class QKTutorialSecondViewController: UIViewController {
    
    private let thirdTotorialSegueId = "QKThirdTotorialSegueId"

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func updateUI() {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let tutorialThirdViewController = segue.destination as? QKTutorialThirdViewController {
            
        }
    }

}

// MARK: - QKTutorialFlippingProtocol

extension QKTutorialSecondViewController: QKTutorialFlippingProtocol {

    func nextAction() {
        performSegue(withIdentifier: thirdTotorialSegueId, sender: nil)
    }

}
