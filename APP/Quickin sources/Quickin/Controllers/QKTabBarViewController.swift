//
//  QKTabBarViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

let isShowedTutorialKey: String = "isShowedTutorial"

class QKTabBarViewController: UITabBarController {
    
    private let totorialSegueId = "QKTotorialSegueId"


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.standard.bool(forKey: isShowedTutorialKey) {
            UserDefaults.standard.set(true, forKey: isShowedTutorialKey)
            performSegue(withIdentifier: totorialSegueId, sender: nil)
        }
    }
    
}
