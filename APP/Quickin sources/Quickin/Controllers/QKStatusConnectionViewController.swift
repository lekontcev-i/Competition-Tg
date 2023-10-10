//
//  QKStatusConnectionViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 28.10.2021.
//

import UIKit

final class QKStatusConnectionViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }
    
    func setCurrentStatus(_ status: String) {
        statusLabel.text = status
    }
    
    
}
