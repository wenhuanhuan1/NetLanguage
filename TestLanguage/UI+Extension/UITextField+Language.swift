//
//  UITextField+Language.swift
//  TestLanguage
//
//  Created by WHH on 2022/1/13.
//

import Foundation
import UIKit
private var textFiledKey = "textFiledKey"
private var textFiledPlaceholderKey = "textFiledPlaceholderKey"
extension UITextField {
    var whhText: WHHLanguage.Text? {
        get {
            guard let rawValue = language_valueFor(&textFiledKey) else { return nil }
            return WHHLanguage.Text(rawValue: rawValue)
        }
        set {
            guard let value = newValue?.rawValue else { return }
            register(value, methodKey: "setText:", dataKey: &textFiledKey)
            text = WHHLanguageManager.shared.textOf(key: value)
        }
    }

    var whhPlaceHolder: WHHLanguage.Text? {
        get {
            guard let rawValue = language_valueFor(&textFiledPlaceholderKey) else { return nil }
            return WHHLanguage.Text(rawValue: rawValue)
        }
        set {
            guard let value = newValue?.rawValue else { return }
            register(value, methodKey: "setPlaceholder:", dataKey: &textFiledPlaceholderKey)
            placeholder = WHHLanguageManager.shared.textOf(key: value)
        }
    }
}

