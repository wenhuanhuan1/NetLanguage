//
//  UINavigationItem+Language.swift
//  TestLanguage
//
//  Created by WHH on 2022/1/13.
//

import Foundation
import UIKit
private var navigationItemKey = "navigationItemKey"
extension UINavigationItem {
    var whhTitle: WHHLanguage.Text? {
        get {
            guard let rawValue = language_valueFor(&navigationItemKey) else { return nil }
            return WHHLanguage.Text(rawValue: rawValue)
        }
        set {
            guard let value = newValue?.rawValue else { return }
            register(value, methodKey: "setTitle:", dataKey: &navigationItemKey)
            title = WHHLanguageManager.shared.textOf(key: value)
        }
    }
}
