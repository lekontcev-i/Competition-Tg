//
//  UIViewController+Extensions.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit

// MARK: Basic UI Extensions
extension UIViewController {
    
    var bottomSafeDistance: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        } else {
            return 0.0
        }
    }
    
    var topSafeDistance: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.top
        } else {
            return 0.0
        }
    }
    
    var bottomDistanceWithTabBar: CGFloat {
        return bottomSafeDistance + (tabBarController?.tabBar.frame.size.height ?? 0.0)
    }
    
    func configureFloatButtonState(
        for floatingView: UIView,
        with distance: CGFloat = 20,
        and constraint: NSLayoutConstraint,
        shouldBeHidden: Bool
    ) {
        constraint.constant = distance
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: { _ in
            floatingView.isHidden = shouldBeHidden
        })
    }
}

// MARK: Navigation Styles / Setup
extension UIViewController {
        
    func restoreNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }

    @objc private func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func startLoading(isfullScreen: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.startLoadingFree(isfullScreen: isfullScreen)
        }
    }
    
    func startLoadingFree(isfullScreen: Bool = true) {
        
        guard let pView = navigationController?.view ?? view else {
            return
        }

        guard pView.viewWithTag(1234) == nil else {
            return
        }
        
        var bottomInsets: CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomInsets = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        let loaderView = QKNextLoaderView()
        loaderView.tag = 1234
        loaderView.isHidden = true
        
        pView.addSubview(loaderView)
        pView.bringSubviewToFront(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loaderView.leftAnchor.constraint(equalTo: pView.leftAnchor),
            loaderView.bottomAnchor.constraint(equalTo: pView.bottomAnchor, constant: bottomInsets),
            loaderView.rightAnchor.constraint(equalTo: pView.rightAnchor),
            loaderView.topAnchor.constraint(equalTo: pView.topAnchor)
        ])
        
        loaderView.startLoading()
        loaderView.animatedShow()
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.stopLoadingFree()
        }
    }
    
    func stopLoadingFree() {
        guard
            let pView = navigationController?.view ?? view,
            let loaderView = pView.subviews.first(where: {$0 is QKNextLoaderView})
        else { return }
        loaderView.animatedHide { loaderView.removeFromSuperview()}
    }
    
}
