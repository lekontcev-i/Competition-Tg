//
//  QKWiFiConnectViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 26.08.2021.
//

import UIKit
import smartwifi_ios_sdk

class QKWiFiConnectViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!

    @IBOutlet weak var apiKeyTextField: QKTextFieldInset!
    @IBOutlet weak var userIdTextField: QKTextFieldInset!
    @IBOutlet weak var channelIdTextField: QKTextFieldInset!
    @IBOutlet weak var projectIdTextField: QKTextFieldInset!

    @IBOutlet var fields: [QKTextFieldInset]!
    
    @IBOutlet weak var connectingView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var connectionButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!

    private var wifiSession: SWFWiFiSession!
    private let userDefaults = UserDefaults(suiteName: kSharedGroupName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wifiSession = SWFWiFiSession(teamId: "28LW9SX73B", delegate: self)
        
        updateUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        createSession()
    }

    // MARK: - UI
    
    private func updateUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        containerView.addCorners(cornerRadius: 20.0)

        
        connectionButton.layer.cornerRadius = connectionButton.frame.size.height * 0.5

        connectingView.isHidden = true
        
        fields.forEach {
//            $0.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

            $0.layer.cornerRadius = $0.frame.size.height * 0.5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.init(red: 0.976, green: 0.659, blue: 0.149, alpha: 1).cgColor
        }
        
        apiKeyTextField.text = ApiConstantsQuickin.apiKey
        userIdTextField.text = userDefaults?.string(forKey: kUserIdKey) ?? UIDevice.current.identifierForVendor?.uuidString ?? ""
        channelIdTextField.text = ApiConstantsQuickin.channelId
        projectIdTextField.text = ApiConstantsQuickin.projectId
        
        disconnectButton.layer.cornerRadius = disconnectButton.frame.size.height * 0.5
        disconnectButton.layer.borderWidth = 1
        disconnectButton.layer.borderColor = UIColor.init(red: 0.976, green: 0.659, blue: 0.149, alpha: 1).cgColor
    }

    private func startInitialization() {
        connectingView.isHidden = false
        disconnectButton.isHidden = true
        statusLabel.text = "Инициализация сессии!"
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func startRequestConfigs() {
        connectingView.isHidden = false
        disconnectButton.isHidden = true
        statusLabel.text = "Получение конфига!"
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func successRequestConfigs() {
        statusLabel.text = "Конфиг сохранен!"
        activityIndicator.stopAnimating()
    }

    private func errorRequestConfigs(_ error: Error) {
        statusLabel.text = error.localizedDescription + "\n\n" + ((error as NSError).userInfo["AdditionalInfo"] as? String ?? "")
        disconnectButton.isHidden = false
        activityIndicator.stopAnimating()
    }

    private func startConnection() {
        connectingView.isHidden = false
        statusLabel.text = "Подключение к WiFi!"
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func successConnection() {
        statusLabel.text = "Подключено!"
        disconnectButton.isHidden = false
        activityIndicator.stopAnimating()
    }

    private func errorConnection(_ error: Error) {
        statusLabel.text = error.localizedDescription + "\n\n" + ((error as NSError).userInfo["AdditionalInfo"] as? String ?? "")
        disconnectButton.isHidden = false
        activityIndicator.stopAnimating()
    }

    private func disconnection() {
        activityIndicator.stopAnimating()
        disconnectButton.isHidden = true
        connectingView.isHidden = true
    }

    private func againConnect() {
        connectingView.isHidden = true
        disconnectButton.isHidden = true
        activityIndicator.stopAnimating()

    }
    
    // MARK: - Actions
    
    private func createSession() {
        
//        let sessionObject = SWFSessionObject(
//            apiKey: ApiConstantsQuickin.apiKey,
//            userId: userDefaults?.string(forKey: kUserIdKey) ?? UIDevice.current.identifierForVendor?.uuidString ?? "",
//            payloadId: userDefaults?.string(forKey: kPayloadKey),
//            channelId: ApiConstantsQuickin.channelId,
//            projectId: ApiConstantsQuickin.projectId,
//            apiDomain: ApiConstantsQuickin.apiDomain
//        )
        
        let sessionObject = SWFSessionObject(
            apiKey: ApiConstantsUmico.apiKey,
            userId: userDefaults?.string(forKey: kUserIdKey) ?? UIDevice.current.identifierForVendor?.uuidString ?? "",
            payloadId: userDefaults?.string(forKey: kPayloadKey),
            channelId: ApiConstantsUmico.channelId,
            projectId: ApiConstantsUmico.projectId,
            apiDomain: ApiConstantsUmico.apiDomain
        )

        wifiSession.createSession(sessionObject: sessionObject) { _ in }
    }

    private func tryConnectToWiFi() {
        wifiSession.startSession()
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressConnectButton(_ sender: Any) {
        tryConnectToWiFi()
    }
    
    @IBAction func didPressDisconnectButton(_ sender: Any) {
        wifiSession.cancelSession()
        disconnection()
    }
    
    // MARK: - Help Methods
    
    func openWiFiSettings() {
        
        func openSettings(alert: UIAlertAction!) {
            if let url = URL.init(string: "App-prefs:root=WIFI") {
                UIApplication.shared.open(url, options: [:]) { [weak self] result in
                    if result {
                        self?.againConnect()
                    }
                }
            }
        }

        let alert = UIAlertController(title: "Attention!",
                                      message: "Please check on WiFi",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Settings",
                                      style: UIAlertAction.Style.default,
                                      handler: openSettings))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))

        present(alert, animated: true, completion: nil)
    }
}

// MARK: - SWFWiFiSessionDelegate

extension QKWiFiConnectViewController: SWFWiFiSessionDelegate {
 
    func willCreate(session: SWFWiFiSession) {
        startRequestConfigs()
    }
    
    func didCreate(session: SWFWiFiSession, error: SWFError?) {
        
        if let error = error {
            errorRequestConfigs(error)
        } else {
            successRequestConfigs()
        }
    }

    func willConnectToWiFi(session: SWFWiFiSession) {
        startConnection()
    }
    
    func didConnectToWiFi(via configType: SWFConfigType?, session: SWFWiFiSession, error: SWFError?) {

        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 2) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                if let error = error {
                    self?.errorConnection(error)
                } else {
                    self?.successConnection()
                }
            }
        }
    }

    func didStopWiFi(session: SWFWiFiSession) {
        
    }

}
