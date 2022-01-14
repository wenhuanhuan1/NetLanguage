//
//  UILabel+Language.swift
//  TestLanguage
//
//  Created by WHH on 2022/1/13.
//

import Foundation
import UIKit

private var labelTextKey = "labelTextKey"
private var labelAttributedTextKey = "labelAttributedTextKey"
extension UILabel {
    var whhText: WHHLanguage.Text? {
        get {
            guard let rawValue = language_valueFor(&labelTextKey) else { return nil }
            return WHHLanguage.Text(rawValue: rawValue)
        }
        set {
            guard let value = newValue?.rawValue else { return }
            register(value, methodKey: "setText:", dataKey: &labelTextKey)
            text = WHHLanguageManager.shared.textOf(key: value)
        }
    }

//    var whhAttributedText: WHHLanguage.Text? {
//        get {
//        guard let rawValue = language_valueFor(&labelAttributedTextKey) else { return nil }
//        return WHHLanguage.Text(rawValue: rawValue)
//       }
//        set {
//            guard let value = newValue?.rawValue else { return }
//            register(value, methodKey: "setAttributedText:", dataKey: &labelTextKey)
//            attributedText = WHHLanguageManager.shared.textOf(key: value)
//        }
}
