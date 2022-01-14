//
//  UITextView+Language.swift
//  TestLanguage
//
//  Created by WHH on 2022/1/13.
//

import Foundation
import UIKit
private var textViewTextKey = "textViewTextKey"
extension UITextView {
    var whhText: WHHLanguage.Text? {
        get {
            guard let rawValue = language_valueFor(&textViewTextKey) else { return nil }
            return WHHLanguage.Text(rawValue: rawValue)
        }
        set {
            guard let value = newValue?.rawValue else { return }
            register(value, methodKey: "setText:", dataKey: &textViewTextKey)
            text = WHHLanguageManager.shared.textOf(key: value)
        }
    }
}
