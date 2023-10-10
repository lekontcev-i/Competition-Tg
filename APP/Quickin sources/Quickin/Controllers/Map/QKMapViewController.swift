//
//  QKMapViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit
import smartwifi_ios_sdk
import YandexMapsMobile
import Karte

private let moscowCenter = (latitude: 55.75370, longitude: 37.619813)

final class QKPoint: LocationPoint {
    
    let location: String
    let id: Int
    
    init(location: String, id: Int) {
        self.location = location
        self.id = id
    }
}


final class QKMapViewController: UIViewController {
    
    @IBOutlet private weak var mapView: YMKMapView!
    @IBOutlet private weak var mapControls: QKMapControlsView!

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchField: QKTextFieldInset!
    @IBOutlet private weak var settingsButton: UIButton!

    private let mapManager: QKMapManager = QKMapManagerImpl(
        latitude: moscowCenter.latitude,
        longitude: moscowCenter.longitude
    )

    private var wifiSession: SWFWiFiSession!
    private let userDefaults = UserDefaults(suiteName: kSharedGroupName)
    private var pointInfoController: UIViewController?

    private var pointModels: [QKQuickinPointModel] = [] {
        didSet {
            var points = [QKPoint]()
            
            for i in 0..<pointModels.count {
                let model = pointModels[i]
                let point = QKPoint(location: "\(model.latitude),\(model.longitude)", id: i)
                points.append(point)
            }
            pickupPoints = points
//            pickupPoints = pointModels.map { QKPoint(location: "\($0.latitude),\($0.longitude)", id: 0) }
        }
    }

    private var pickupPoints: [QKPoint] = []{
        didSet {
            mapManager.addPointsToCenter(points: pickupPoints)
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        wifiSession = SWFWiFiSession(teamId: "28LW9SX73B", delegate: self)
        
        updateUI()
        configureMaps()
        initialMapSetup(with: mapView)
        
        if let jsonData = try? JSONSerialization.data(withJSONObject:DummyData.dummyData) {
            
            guard let pointModels = try? JSONDecoder().decode([QKQuickinPointModel].self, from: jsonData) else {
                return
            }
            
            self.pointModels = pointModels
        }
    }
    
    private func updateUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        containerView.addCorners(cornerRadius: 20.0)
        
        searchField.setRounded()
        searchField.addBorder(color: UIColor.qkGray.cgColor)
        
        searchField.rightViewMode = .always
        let imageView = UIImageView(image: UIImage(named: "ic_search"))
        imageView.tintColor = UIColor.qkDarkGray
        imageView.contentMode = .center
        searchField.rightView = imageView
        searchField.rightView?.backgroundColor = .clear
        
        searchField.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [
            .foregroundColor: UIColor.qkDarkGray,
            .font: UIFont.qkMedium(16)
        ])
        
        settingsButton.setRounded()
        settingsButton.addBorder(color: UIColor.qkGray.cgColor)
        
        mapControls.delegate = self
    }

    func initialMapSetup(with mapView: YMKMapView) {
        mapManager.initialSetup(with: mapView)
        mapManager.delegate = self
        mapManager.addPointsToCenter(points: pickupPoints)
    }

    private func configureMaps() {
        let point = YMKPoint(latitude: moscowCenter.latitude, longitude: moscowCenter.longitude)
        let position = YMKCameraPosition.init(target: point, zoom: 15, azimuth: 0, tilt: 0)
        let animation = YMKAnimation(type: .smooth, duration: 5)
        
        mapView.mapWindow.map.move(
            with: position,
            animationType: animation,
            cameraCallback: nil
        )
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressSettingsButton(_ sender: Any) {
    }

}

extension QKMapViewController: QKMapControlsDelegate {
    
    func plusButtonDidTap() {
        mapManager.plusButtonDidTap()
    }
    
    func minusButtonDidTap() {
        mapManager.minusButtonDidTap()
    }
    
    func locationButtonDidTap() {
        mapManager.locationButtonDidTap()
    }
    
}

extension QKMapViewController: QKMapManagerDelegate {
    
    func didTapOnMap() {
        mapManager.deselectPoint()
    }
    
    func didUpdateMapCenter() {
        
    }
    
    func confirmPoint(_ point: QKQuickinPointModel) {
        
        createSessionWith(point)
        
//        onChoosePickupPoint(point)
//        view?.navigationController?.popViewController(animated: true)
    }

    func showPointInfo(_ point: QKQuickinPointModel) {

//        navigator.presentConfigurablePopup(
//            from: pointInfoController ?? view,
//            type: .marketplacePointInfo(point.informerString)
//        ) { _ in
//            view.dismiss(animated: true, completion: nil)
//        }
    }
    
    func didSelectLocationPoint(point: LocationPoint) {
        
        let model = pointModels[point.id]

        let closeBlock = { [weak self] in
            self?.mapManager.deselectPoint()
            self?.pointInfoController = nil
        }

        let onConfirmBlock: Closure1<QKQuickinPointModel> = { [weak self] pointModel in
            self?.confirmPoint(pointModel)
        }

        let infoBlock: Closure1<QKQuickinPointModel> = { [weak self] pointModel in
            self?.showPointInfo(pointModel)
        }

        let pointInfoController = QKBottomSheetInjectionController.presentPickupPointController(
            pickupPointModel: model,
            closeBlock: closeBlock,
            confirmAction: onConfirmBlock,
            authorizationInfoAction: infoBlock
        )

        pointInfoController.topMinYPosition = topSafeDistance 
        self.pointInfoController = pointInfoController
        present(pointInfoController, animated: true)
    }
    
    private func showMapsSelectionAlert(_ point: QKQuickinPointModel) {
        Karte.presentPicker(destination: point, presentOn: self)
    }

}

extension QKMapViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

// MARK: - WiFi connection flow

extension QKMapViewController {
    
    private func createSessionWith(_ point: QKQuickinPointModel) {
        let apiKey: String
        let userId: String = userDefaults?.string(forKey: kUserIdKey) ?? UIDevice.current.identifierForVendor?.uuidString ?? ""
        let payloadId: String? = point.payloadId ?? userDefaults?.string(forKey: kPayloadKey)
        let channelId: String
        let projectId: String
        let apiDomain: String

        switch point.type.code {
        case .smart:
            apiKey = ApiConstantsSmart.apiKey
            channelId = ApiConstantsSmart.channelId
            projectId = ApiConstantsSmart.projectId
            apiDomain = ApiConstantsSmart.apiDomain
        case .mfc:
            apiKey = ApiConstantsMFCTest.apiKey
            channelId = ApiConstantsMFCTest.channelId
            projectId = ApiConstantsMFCTest.projectId
            apiDomain = ApiConstantsMFCTest.apiDomain
        case .neftmagistral:
            apiKey = ApiConstantsNeftmagistral.apiKey
            channelId = ApiConstantsNeftmagistral.channelId
            projectId = ApiConstantsNeftmagistral.projectId
            apiDomain = ApiConstantsNeftmagistral.apiDomain
        case .domru:
            apiKey = ApiConstantsDomru.apiKey
            channelId = ApiConstantsDomru.channelId
            projectId = ApiConstantsDomru.projectId
            apiDomain = ApiConstantsDomru.apiDomain
        case .quickin:
            apiKey = ApiConstantsQuickin.apiKey
            channelId = ApiConstantsQuickin.channelId
            projectId = ApiConstantsQuickin.projectId
            apiDomain = ApiConstantsQuickin.apiDomain
        case .umico:
            apiKey = ApiConstantsUmico.apiKey
            channelId = ApiConstantsUmico.channelId
            projectId = ApiConstantsUmico.projectId
            apiDomain = ApiConstantsUmico.apiDomain
        }
        
        let sessionObject = SWFSessionObject(
            apiKey: apiKey,
            userId: userId,
            payloadId: payloadId,
            channelId: channelId,
            projectId: projectId,
            apiDomain: apiDomain
        )
        
        wifiSession.createSession(sessionObject: sessionObject) { [weak self] (result) in
            if case .success = result {
                self?.tryConnectToWiFi()
            }
        }
    }

//    private func getSessionConfig() {
//        wifiSession.getSessionConfig() { [weak self] (result) in
//            self?.tryConnectToWiFi()
////            switch result {
////            case .success:
////                self?.tryConnectToWiFi()
////
////            case .failure(let error):
////                switch error {
////                case .getWiFiSettingsRequestFailure(serverError: let _error):
////                    let nsError = (_error as NSError)
////                    if !(nsError.domain == "NSURLErrorDomain" && nsError.code == -1009) {
////                        self?.tryConnectToWiFi()
////                    }
////                default:
////                    self?.tryConnectToWiFi()
////                }
////            }
//        }
//    }

    private func tryConnectToWiFi() {
        wifiSession.startSession()
    }

    private func configTypeDescription(configType: SWFConfigType?) -> String {
        guard let configType = configType else {
            return ""
        }
        switch configType {
        case .passpoint:
            return "Passpoint"
        case .wpa2Enterprise:
            return "Wpa2Enterprise"
        case .wpa2:
            return "Wpa2"
        }
    }
    
    private func showErrorAlert(_ error: Error, for configType: SWFConfigType?) {
//        dismiss(animated: false, completion: nil)
        
        let alert = UIAlertController(
            title: configTypeDescription(configType: configType) + " Ошибка!",
            message: error.localizedDescription,
            preferredStyle: .alert
        )

        alert.modalPresentationStyle = .currentContext
        
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: nil
            )
        )

        let presentedViewController = presentedViewController ?? self
        presentedViewController.present(alert, animated: true, completion: nil)
    }
    
    private func showSuccessAlert(for configType: SWFConfigType?) {
//        dismiss(animated: false, completion: nil)
        
        let alert = UIAlertController(
            title: configTypeDescription(configType: configType) + " Успех!",
            message: "Успешное подключение к Wi-Fi",
            preferredStyle: .alert
        )

        alert.modalPresentationStyle = .overCurrentContext
        
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: nil
            )
        )

        let presentedViewController = presentedViewController ?? self
        presentedViewController.present(alert, animated: true, completion: nil)
    }

    private func showDisconnectAlert() {
//        dismiss(animated: false, completion: nil)
        
        let alert = UIAlertController(title: "Отключено!",
                                      message: "WiFi сеть успешно отключена",
                                      preferredStyle: .alert)

        alert.modalPresentationStyle = .currentContext
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))

        let presentedViewController = presentedViewController ?? self
        presentedViewController.present(alert, animated: true, completion: nil)
    }

}

// MARK: - SWFWiFiSessionDelegate

extension QKMapViewController: SWFWiFiSessionDelegate {
 
    func willCreate(session: SWFWiFiSession) {
        startLoading()
    }
    
    func didCreate(session: SWFWiFiSession, error: SWFError?) {
        
        if let error = error {
            
            if case SWFError.noInternetConnection = error {
            } else {
                showErrorAlert(error, for: nil)
                stopLoading()
            }
        }
    }

    func willConnectToWiFi(session: SWFWiFiSession) {
        startLoading()
    }
    
    func didConnectToWiFi(via configType: SWFConfigType?, session: SWFWiFiSession, error: SWFError?) {
        stopLoading()
        
        if let error = error {

//            if case .unableToJoinNetwork = error, configType == .wpa2 {
////            } else if case .saveIdentifierFailure = error, configType == .wpa2 {
//            } else {
                showErrorAlert(error, for: configType)
//            }
        } else {
            showSuccessAlert(for: configType)
        }
    }

    func didStopWiFi(session: SWFWiFiSession) {
        showDisconnectAlert()
    }
    
}


