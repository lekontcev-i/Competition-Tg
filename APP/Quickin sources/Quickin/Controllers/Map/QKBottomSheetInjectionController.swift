//
//  QKBottomSheetInjectionController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit
import Karte

struct QKBottomSheetProprties {
    static let fastGestureValue: CGFloat = 0.6
    static let animationDuration: TimeInterval = 0.25
}

final class QKBottomSheetInjectionController: UIViewController {
    
    @IBOutlet private weak var bottonBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var viewsStackView: UIStackView!
    @IBOutlet private weak var contanerTopLayoutConstraint: NSLayoutConstraint!
        
    private var confirmAction: Closure1<QKQuickinPointModel>?
    private var authorizationInfoAction: Closure1<QKQuickinPointModel>?
    private var closeBlock: Closure?
    
    private var pickupPointModel: QKQuickinPointModel?

    private var pudoImages: [String] = []

    var topMinYPosition: CGFloat = 0
    
    var yPosition = CGFloat.infinity
    
    // MARK: Class methods
    @discardableResult
    static func presentPickupPointController(
        pickupPointModel: QKQuickinPointModel?,
        closeBlock: @escaping Closure,
        confirmAction: @escaping Closure1<QKQuickinPointModel>,
        authorizationInfoAction: @escaping Closure1<QKQuickinPointModel>
    ) -> QKBottomSheetInjectionController {
        
        let controller = QKBottomSheetInjectionController()
        controller.modalPresentationStyle = .overFullScreen
        controller.pickupPointModel = pickupPointModel
        controller.authorizationInfoAction = authorizationInfoAction
        controller.confirmAction = confirmAction
        controller.closeBlock = closeBlock
        
        return controller
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView?.panGestureRecognizer.addTarget(self, action: #selector(panHandle(_:)))

        fillViews()
        
        containerView.layer.shadowColor = UIColor(red: 32 / 255, green: 39 / 255, blue: 61 / 255, alpha: 0.15).cgColor
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 1
        containerView.layer.masksToBounds = false
        containerView.clipsToBounds = false
        
        scrollView?.layer.cornerRadius = 10
        scrollView?.layer.masksToBounds = true
        
        contanerTopLayoutConstraint.constant = topMinYPosition
        setupStartTransfrom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bottonBottomLayoutConstraint.constant = 30 + bottomSafeDistance
        startOpenAnimation()
    }
    
    // MARK: fill method
    func fillViews() {
        let pointView = QKQuickinPointView()

        pointView.fill(
            with: self.pickupPointModel,
            confirmAction: { [weak self] pickupPoint in
                self?.startCloseAnimation() {
                    self?.confirmAction?(pickupPoint)
                }
            },
            authorizationInfoAction: self.authorizationInfoAction,
            onMapAction: { [weak self] point in
                point.map { self?.showMapsSelectionAlert($0) }
            }
        )

        pointView.backgroundColor = .clear
        viewsStackView.addArrangedSubview(pointView)
    }
    
    // MARK: user interactions
    @IBAction func onClose(_ sender: Any) {
        self.startCloseAnimation()
    }
    
//    @IBAction func onShowList(_ sender: Any) {
//        self.startCloseAnimation(1, completion: showListBlock)
//    }
    
    @IBAction func panHandle(_ gest: UIPanGestureRecognizer) {
        let view: UIView = containerView
        let gestureView = view
        let velocityY = gest.velocity(in: gestureView).y
        let isScrollGest = gest == scrollView?.panGestureRecognizer
        let minYOffset:CGFloat = 0 - (scrollView?.contentInset.top ?? 0)
        if isScrollGest && (scrollView?.contentOffset.y ?? 0) > minYOffset && view.transform.isIdentity {
            yPosition = CGFloat.infinity
            return
        }
        
        if !isScrollGest && (scrollView?.contentOffset.y ?? 0) > 0 {
            return
        }
        
        let currentLocation = gest.translation(in: gestureView).y
        if yPosition.isInfinite {
            yPosition = currentLocation
        }
        
        let zeroPoint = CGPoint(x: 0, y: minYOffset)
        scrollView?.setContentOffset(zeroPoint, animated: false)
        switch gest.state {
        case .changed:
            if isScrollGest {
                let yDelta = currentLocation - yPosition
                view.transform = .init(translationX: 0, y: max(0, yDelta))
            } else {
                let yTransform = max(0, currentLocation)
                view.transform = .init(translationX: 0, y: yTransform)
            }
        case .cancelled, .ended, .failed:
//            let durationFactor:Double = max(1, abs(Double(velocityY))/1000)
            
            let yValue = view.transform.ty
            
            let height = view.frame.height
            let duration = height / velocityY
            
            if velocityY > 0, duration < QKBottomSheetProprties.fastGestureValue { // swipeDown
                startCloseAnimation()
            } else if velocityY < 0, duration > -QKBottomSheetProprties.fastGestureValue { // swipeUp
                startOpenAnimation()
            } else if yValue < view.frame.height / 3 {
                startOpenAnimation()
            } else {
                startCloseAnimation()
            }
            
            yPosition = CGFloat.infinity
        default:
            break
        }
    }
    
    private func showMapsSelectionAlert(_ point: QKQuickinPointModel) {
        Karte.presentPicker(destination: point, presentOn: self)
    }

    // MARK: Animations
    func setupStartTransfrom() {
        containerView.transform = .init(translationX: 0, y: view.bounds.height)
    }
    
    func startOpenAnimation() {
        UIView.animate(
            withDuration: QKBottomSheetProprties.animationDuration,
            animations: { [weak self] in
                self?.containerView.transform = .identity
            }
        )
    }
    
    func startCloseAnimation(completion: Closure? = nil) {
        UIView.animate(
            withDuration: QKBottomSheetProprties.animationDuration,
            animations: { [weak self] in
                self?.setupStartTransfrom()
            }
        ) { [weak self] finished in
            if finished {
                self?.closeBlock?()
                self?.dismiss(animated: false) {
                    completion?()
                }
            }
        }
    }
}
