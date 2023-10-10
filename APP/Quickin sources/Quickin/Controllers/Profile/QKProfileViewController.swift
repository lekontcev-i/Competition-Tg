//
//  QKProfileViewController.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 01.09.2021.
//

import UIKit

final class QKProfileViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var infoView: UIStackView!
    @IBOutlet private weak var infoBackView: UIView!
    @IBOutlet private var infoBackPaddingsView: [UIView]!
    @IBOutlet weak var infoBackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoBackViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var avatarEditButtonsView: UIStackView!
    
    @IBOutlet private weak var userNameControl: QKChangeValueControl!
    @IBOutlet private weak var phoneControl: QKChangeValueControl!
    @IBOutlet private weak var appLanguageControl: QKPickValueControl!
    @IBOutlet private weak var automaticAccessLevel: QKPickValueControl!

    @IBOutlet private weak var saveButton: QKQuickinButton!
    @IBOutlet private weak var cancelButton: QKQuickinButton!
    @IBOutlet private weak var actionButtonsViewView: UIView!

    @IBOutlet private weak var settingsView: UIView!

    @IBOutlet private var settingsButtons: [QKSettingButton]!
    
    private var isEdit: Bool = false

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // MARK: - UI

    private func setEditingMode(_ isEdit: Bool, animation: Bool) {
        self.isEdit = isEdit
                
        userNameControl.setEnable(isEdit, animation: animation)
        phoneControl.setEnable(isEdit, animation: animation)
        appLanguageControl.setEnable(isEdit, animation: animation)
        automaticAccessLevel.setEnable(isEdit, animation: animation)
        
        infoBackViewHeightConstraint.constant = isEdit ? 200 : 0
        
        guard animation else {
            avatarEditButtonsView.isHidden = !isEdit
            automaticAccessLevel.isHidden = !isEdit
            actionButtonsViewView.isHidden = !isEdit
            infoBackPaddingsView.forEach {
                $0.isHidden = isEdit
            }
            infoBackViewBottomConstraint.constant = isEdit ? 0 : 180
            return
        }
        
        if isEdit {
            avatarEditButtonsView.alpha = 0
            automaticAccessLevel.alpha = 0
            actionButtonsViewView.alpha = 0
        }
        
        UIView.animate(withDuration: 0.2) {
            
            self.infoBackPaddingsView.forEach {
                $0.isHidden = isEdit
            }

            self.infoBackViewBottomConstraint.constant = isEdit ? 0 : 180

            if isEdit {
                self.avatarEditButtonsView.isHidden = false
                self.automaticAccessLevel.isHidden = false
                self.actionButtonsViewView.isHidden = false
            } else {
                self.avatarEditButtonsView.alpha = 0
                self.automaticAccessLevel.alpha = 0
                self.actionButtonsViewView.alpha = 0
            }
            
        } completion: { finish in
            
            if finish {
                UIView.animate(withDuration: 0.2) {
                    if isEdit {
                        self.avatarEditButtonsView.alpha = 1
                        self.automaticAccessLevel.alpha = 1
                        self.actionButtonsViewView.alpha = 1
                    } else {
                        self.avatarEditButtonsView.isHidden = true
                        self.automaticAccessLevel.isHidden = true
                        self.actionButtonsViewView.isHidden = true
                    }
                }
            }
        }
    }
    
    private func updateUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        setEditingMode(false, animation: false)
        
        infoBackView.addCorners(cornerRadius: 20.0)
        
        let titles: [String] = ["Автодоступ сервисов к личным данным",
                                "Настойки конфиденциальности",
                                "Выйти",
                                "Удалить аккаунт"]
        
        let iconsNames: [String] = ["ic_unlock",
                                    "ic_pocket",
                                    "ic_logout",
                                    "ic_trash"]

        settingsButtons.forEach {
            guard let buttonIndex = settingsButtons.firstIndex(of: $0) else {
                return
            }
            
            let title = titles[buttonIndex]
            let iconName = iconsNames[buttonIndex]
            
            $0.configure(
                title: title,
                icon: UIImage(named: iconName),
                action: { (button) in
                    
                }
            )
        }
        
        userNameControl.configure(
            header: "Имя пользователя",
            textValue: "Максим Максимов",
            fieldFont: UIFont.qkRegular(20),
            borderColor: UIColor.qkYellow,
            needConfirm: false
        )
        
        phoneControl.configure(
            header: "Номер телефона",
            textValue: "+7 (454) 78-45-65",
            fieldFont: UIFont.qkMedium(20),
            borderColor: UIColor.qkYellow,
            needConfirm: true
        )

        appLanguageControl.configure(
            header: "Язык приложения",
            title: "Русский",
            titleFont: UIFont.qkMedium(16),
            titleAligment: .center,
            leftIcon: UIImage(named: "ic_ru_flag"),
            borderColor: UIColor.qkYellow,
            action: { (control) in
            }
        )
        
        automaticAccessLevel.configure(
            header: "Автоматический уровень доступа сервисов к личным данным",
            title: "Выбрать",
            titleFont: UIFont.qkRegular(16),
            titleAligment: .center,
            leftIcon: nil,
            borderColor: UIColor.qkYellow,
            action: { (control) in
            }
        )
        
        saveButton.configure(
            style: .clear,
            title: "Сохранить",
            fontSize: 14,
            icon: UIImage(named: "ic_save"),
            iconPosition: .left,
            action: { [weak self] (button) in
                self?.setEditingMode(false, animation: true)
            }
        )

        cancelButton.configure(
            style: .clear,
            title: "Отменить",
            fontSize: 14,
            icon: UIImage(named: "ic_xCircle"),
            iconPosition: .left,
            action: { [weak self] (button) in
                self?.setEditingMode(false, animation: true)
            }
        )

    }
    
    // MARK: - IBActions
    
    @IBAction func didPressEditButton(_ sender: Any) {
        setEditingMode(!isEdit, animation: true)
    }
    
    @IBAction func didPressEditAvatarButton(_ sender: Any) {
    }

    @IBAction func didPressDownloadAvatarButton(_ sender: Any) {
    }

    @IBAction func didPressConfirmPhoneButton(_ sender: Any) {
    }

    
}

