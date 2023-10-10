//
//  UIFontExtension.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 27.08.2021.
//

import UIKit

fileprivate enum FontName: String {
    case bold = "Montserrat-Bold"
    case semiBold = "Montserrat-SemiBold"
    case regular = "Montserrat-Regular"
    case medium = "Montserrat-Medium"
}

extension UIFont {
    
    static func qkBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: FontName.bold.rawValue, size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }

    static func qkSemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontName.semiBold.rawValue, size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }

    static func qkRegular(_ size: CGFloat) -> UIFont {
        UIFont(name: FontName.regular.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func qkMedium(_ size: CGFloat) -> UIFont {
        UIFont(name: FontName.medium.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }

}
