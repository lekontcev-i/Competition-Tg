//
//  ViewController.swift
//  QuickinAppClip
//
//  Created by Vitaliy Pedan on 26.08.2021.
//

import UIKit
import smartwifi_ios_sdk

enum BannerType: String {
    case smart
    case mfc
    case neftmagistral
    case domru
    case quickin
}

struct ApiConstantsQuickin {
    
    static var apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJwaWQiOiIyMCIsInN1YiI6IjQ1NDU1OWE1LTE2ZjgtNDY2Ni1hOGViLTEwM2IyZWE5MTQ1ZCIsImlhdCI6MTYzMTY5NTQzNywic2NvcGVzIjpbInJlZ2lzdHJhdGlvbl9nZXRfd2lmaV9zZXR0aW5ncyJdfQ.8s3_8EARPXlAVOMam8-gYg4NGHC0PJKIHJIVsTQPljW-vx7t94vkUR012rh_f0hA"
    static var channelId = "48"
    static var projectId = "20"
    static var apiDomain = "https://api.smartregion.online"

}

struct ApiConstantsMFC {
    
    static var apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJwaWQiOiIxIiwic3ViIjoiY2Y5ZDRjODMtZjc2MS00N2UwLWIzNjMtNmI1OTQ5YTIwYzM2IiwiaWF0IjoxNjMxNjk3NTIyLCJzY29wZXMiOlsicmVnaXN0cmF0aW9uX2dldF93aWZpX3NldHRpbmdzIl19.jO7mP1IrQ5L2Rdli1VccB-iPjbD2w6jgDsYDhIRkh39yRnx8DXpiPRrPuARJzi3v"
    static var channelId = "1"
    static var projectId = "1"
    static var apiDomain = "https://api.mfc.qsystem.smartregion.moscow:41443"

}

struct ApiConstantsMFCTest {
    
    static var apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJwaWQiOiIyMSIsInN1YiI6ImViZjU5OGM5LWVhZjUtNDhlOC1iZTBiLWM1YzViZGZkZjgxOCIsImlhdCI6MTYzMTY5NTE4Niwic2NvcGVzIjpbInJlZ2lzdHJhdGlvbl9nZXRfd2lmaV9zZXR0aW5ncyJdfQ.3i4cww9HWdTm4SE7jBReGv5J5lEPAoE2aXh0ApGM3fTS-CkcDIqg6GIuAfInBuIz"
    static var channelId = "50"
    static var projectId = "21"
    static var apiDomain = "https://api.smartregion.online"

}

struct ApiConstantsNeftmagistral {
    
    static var apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJwaWQiOiIxNSIsInN1YiI6ImJjNjFiZTU1LTY2MTctNDA0My05ZTkxLTQ5Mzc4MDZlZmVkMSIsImlhdCI6MTYzMTY5NTI5NSwic2NvcGVzIjpbInJlZ2lzdHJhdGlvbl9nZXRfd2lmaV9zZXR0aW5ncyJdfQ.OPWzPVgsRwIuayti1jJU7k74MwR6W341sPOgPfy1LTrj2xFPh6vqoTqPgNtepAsQ"
    static var channelId = "44"
    static var projectId = "15"
    static var apiDomain = "https://api.smartregion.online"

}

struct ApiConstantsDomru {
    
    static var apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJwaWQiOiIyNCIsInN1YiI6IjcyZDRkOTQwLWZjN2UtNGQ2OC1hMTkyLTQ2YTZjNDYyNjIyYyIsImlhdCI6MTYzMTc5NTg0OSwic2NvcGVzIjpbInJlZ2lzdHJhdGlvbl9nZXRfd2lmaV9zZXR0aW5ncyJdfQ.lQHNs4h7IjVsIsZF_4aIrwvp3WDn-rlaBw95raAhpU3mO5AicL30h40HesZabnvo"
    static var channelId = "52"
    static var projectId = "24"
    static var apiDomain = "https://api.smartregion.online"

}

struct ApiConstantsSmart {
    
    static var apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJwaWQiOiIxIiwic3ViIjoiZGNlZTA2NjAtYTQ5OS00ZTMxLWI2N2YtNmI2MWUzNmQyNzMxIiwiaWF0IjoxNjMxMDA3MDgzLCJzY29wZXMiOlsicmVnaXN0cmF0aW9uX2dldF93aWZpX3NldHRpbmdzIl19.i3Xv3JmeyTSUxIItMqke9yfScrV1_18psu38PG9jWJp4RlXxJgFc6tlruJshXbRj"
    static var channelId = "1"
    static var projectId = "1"
    static var apiDomain =  "https://api.sweetlife.smartregion.moscow"

}

let kSharedGroupName: String = "group.quickin.clipGroup"
let kPartnerNameKey: String = "PartnerNameKey"
let kPayloadKey: String = "PayloadKey"
let kUserIdKey: String = "userId"

class QKMainAppClipViewController: UIViewController {

    @IBOutlet private var connectionButton: QKQuickinButton!
    @IBOutlet private var bannerImageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!

    private var wifiSession: SWFWiFiSession!

    private let userDefaults = UserDefaults(suiteName: kSharedGroupName)

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wifiSession = SWFWiFiSession(teamId: "28LW9SX73B", delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

        updateUI(type: getBannerType())
        
        createSession()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Public methods
    
    func updateToPartner() {
        updateUI(type: getBannerType())
    }
    
    // MARK: - Private methods
    
    private func getBannerType() -> BannerType {
        
        var bannerType: BannerType = .quickin
        
        guard let partner = userDefaults?.value(forKey: kPartnerNameKey) as? String
        else {
            return bannerType
        }
        
        if partner == "smart" {
            bannerType = .smart
        } else if partner == "mfc" {
            bannerType = .mfc
        } else if partner == "neftmagistral" {
            bannerType = .neftmagistral
        } else if partner == "domru" {
            bannerType = .domru
        } else if partner == "quickin" {
            bannerType = .quickin
        }
        
        return bannerType
    }

    private func updateUI(type: BannerType) {
        
        view.backgroundColor = backgroundColorWith(type: type)
        bannerImageView.image = bannerImageWith(type: type)
        textLabel.text = textWith(type: type)
        
        connectionButton.configure(
            style: .background,
            title: "Подключиться",
            fontSize: 20,
            icon: UIImage(named: "ic_wifi"),
            iconPosition: .left,
            action: { [weak self] (button) in
                self?.tryConnectToWiFi()
            }
        )
        
        setBackgroundButtonColorWith(type: type)
        setTitleButtonColorWith(type: type)
        
        view.setNeedsDisplay()
    }

    private func bannerImageWith(type: BannerType) -> UIImage? {
        let bannerImageName: String
        
        switch type {
        case .smart:
            bannerImageName = "banner_smart"
        case .mfc:
            bannerImageName = "banner_mfc"
        case .neftmagistral:
            bannerImageName = "banner_neftmagistral"
        case .domru:
            bannerImageName = "banner_domru"
        case .quickin:
            bannerImageName = "banner_quickin"
        }
        
        return UIImage(named: bannerImageName)
    }
    
    private func textWith(type: BannerType) -> String {
        let text: String
        
        switch type {
        case .smart:
            text = "Установите приложение и получайте безлимитный доступ к Wi-Fi сети Магазина, а также уникальные промо предложения, основанные на ваших предпочтениях."
        case .mfc:
            text = "Обслуживание в МФЦ теперь без бумажных талонов и с удобной предварительной записью. Получайте меню электронной очереди прямо в чат-боте при посещении отделения МФЦ с автоматической активацией талона предварительной записи."
        case .neftmagistral:
            text = "Больше не нужно вспоминать о бонусной карте на кассе АЗС, приложение автоматически напомнит вам о ней в момент входа на заправку. Также вы будете получать персональные предложения на ассортимент магазина и Гурманики, основанные на ваших предпочтениях."
        case .domru:
            text = "Больше не нужно подключаться вручную к Wi-Fi сети и вводить каждый раз номер телефона или данные договора с Dom.Ru. Установите приложение и получайте автоматически безлимитный высокоскоростной Интернет во всей Wi-Fi сети Dom.Ru."
        case .quickin:
            text = "Мобильное приложение Quickin ваш персональный ключ для авторизации в Wi-Fi сетях. Зарегистрируйтесь в один клик и получайте Интернет \"как дома\" во всех Wi-Fi сетях в партнерских точках продаж."
        }
        
        return text
    }

    private func backgroundColorWith(type: BannerType) -> UIColor {
        let backgroundColor: UIColor
        
        switch type {
        case .smart:
            backgroundColor = UIColor.qkSmart
        case .mfc:
            backgroundColor = .white //UIColor.qkMfc
        case .neftmagistral:
            backgroundColor = .white //UIColor.qkNeftmagistral
        case .domru:
            backgroundColor = .white //UIColor.qkDomru
        case .quickin:
            backgroundColor = UIColor.qkYellow
        }
        
        return backgroundColor
    }

    private func setBackgroundButtonColorWith(type: BannerType) {
        let backgroundNormalColor: UIColor
        let backgroundHoverColor: UIColor

        switch type {
        case .smart:
            backgroundNormalColor = UIColor(displayP3Red: 111/255, green: 92/255, blue: 204/255, alpha: 1)
            backgroundHoverColor = UIColor(displayP3Red: 109/255, green: 222/255, blue: 165/255, alpha: 1)
        case .mfc:
            backgroundNormalColor = .qkMfc
            backgroundHoverColor = UIColor(displayP3Red: 190/255, green: 149/255, blue: 110/255, alpha: 1)
        case .neftmagistral:
            backgroundNormalColor = .qkNeftmagistral
            backgroundHoverColor = .clear
        case .domru:
            backgroundNormalColor = .qkDomru
            backgroundHoverColor = .clear
        case .quickin:
            backgroundNormalColor = .qkOrange
            backgroundHoverColor = .clear
        }
        
        connectionButton.setBackgroundColor(color: backgroundNormalColor, forState: .normal)
        connectionButton.setBackgroundColor(color: backgroundHoverColor, forState: .hover)
    }
    
    private func setTitleButtonColorWith(type: BannerType) {
        let titleNormalColor: UIColor
        let titleHoverColor: UIColor

        switch type {
        case .smart:
            titleNormalColor = UIColor(displayP3Red: 109/255, green: 222/255, blue: 165/255, alpha: 1)
            titleHoverColor = UIColor(displayP3Red: 111/255, green: 92/255, blue: 204/255, alpha: 1)
        case .mfc:
            titleNormalColor = .white
            titleHoverColor = UIColor(displayP3Red: 98/255, green: 52/255, blue: 35/255, alpha: 1)
        case .neftmagistral:
            titleNormalColor = .white
            titleHoverColor = .qkNeftmagistral
        case .domru:
            titleNormalColor = .white
            titleHoverColor = .qkDomru
        case .quickin:
            titleNormalColor = .white
            titleHoverColor = .qkDarkOrange
        }
        
        connectionButton.setTitleColor(color: titleNormalColor, forState: .normal)
        connectionButton.setTitleColor(color: titleHoverColor, forState: .hover)
    }

    private func createSessionWith(type: BannerType) {
        
        let apiKey: String
        let userId: String = userDefaults?.value(forKey: kUserIdKey) as? String ?? UIDevice.current.identifierForVendor?.uuidString ?? ""
        let payloadId: String? = userDefaults?.string(forKey: kPayloadKey)
        let channelId: String
        let projectId: String
        let apiDomain: String

        switch type {
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
        }
        
        let sessionObject = SWFSessionObject(
            apiKey: apiKey,
            userId: userId,
            payloadId: payloadId,
            channelId: channelId,
            projectId: projectId,
            apiDomain: apiDomain
        )

        wifiSession.createSession(sessionObject: sessionObject) { _ in }
    }
    
}

// MARK: - WiFi connection flow

extension QKMainAppClipViewController {
    
    private func createSession() {
        createSessionWith(type: getBannerType())
    }

    private func tryConnectToWiFi() {
        wifiSession.startSession()
    }

    private func showErrorAlert(_ error: Error) {
        let alert = UIAlertController(title: "Error!",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))

        present(alert, animated: true, completion: nil)
    }

    private func showSuccessAlert() {
        let alert = UIAlertController(title: "Success!",
                                      message: "Success connection to WiFi",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))

        present(alert, animated: true, completion: nil)
    }

    private func showDisconnectAlert() {
        let alert = UIAlertController(title: "Disconnect!",
                                      message: "Success disconnect WiFi",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))

        present(alert, animated: true, completion: nil)
    }

}

// MARK: - SWFWiFiSessionDelegate

extension QKMainAppClipViewController: SWFWiFiSessionDelegate {
        
    func willCreate(session: SWFWiFiSession) {
        startLoading()
    }
    
    func didCreate(session: SWFWiFiSession, error: SWFError?) {
        if let error = error {
            showErrorAlert(error)
        }
        stopLoading()
    }

    func willConnectToWiFi(session: SWFWiFiSession) {
        startLoading()
    }
    
    func didConnectToWiFi(via configType: SWFConfigType?, session: SWFWiFiSession, error: SWFError?) {
        if let error = error {
            showErrorAlert(error)
        } else {
            showSuccessAlert()
        }
        stopLoading()
    }

    func didStopWiFi(session: SWFWiFiSession) {
        showDisconnectAlert()
    }

}
