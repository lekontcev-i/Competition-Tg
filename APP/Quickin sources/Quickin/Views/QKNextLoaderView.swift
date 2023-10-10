//
//  QKNextLoaderView.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit

final class QKNextLoaderView: UIView, QKXibLoadable {
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var loaderView: UIView!
    @IBOutlet private weak var loaderImage: UIImageView!
    
    private enum LocalConstants {
        static let alpha: CGFloat = 0.2
    }
    
    var contentView: UIView?
       
    // MARK: - LifeCycle

    override init(frame: CGRect) {
       super.init(frame: frame)
       setupXib(frame)
       setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       setupXib(bounds)
       setupUI()
    }
    
    private func setupUI() {
        backView.backgroundColor = UIColor.black.withAlphaComponent(LocalConstants.alpha)
        backgroundColor = .clear
        
        loaderView.setRounded()
    }
    
    func startLoading() {
        loaderView.startRotation()
    }
    
    func stopLoading() {
        loaderView.stopRotation()
    }
    
}
