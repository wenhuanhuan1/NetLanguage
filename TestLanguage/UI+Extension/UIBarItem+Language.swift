//
//  UIBaritem+Language.swift
//  TestLanguage
//
//  Created by WHH on 2022/1/13.
//

import Foundation
import UIKit
private var barItemTitleKey = "barItemTitleKey"

extension UIBarItem {
    var whhTitle: WHHLanguage.Text? {
        get {
            guard let rawValue = language_valueFor(&barItemTitleKey) else { return nil }
            return WHHLanguage.Text(rawValue: rawValue)
        }
        set {
            guard let value = newValue?.rawValue else { return }
            register(value, methodKey: "setTitle:", dataKey: &barItemTitleKey)
            title = WHHLanguageManager.shared.textOf(key: value)
        }
    }
}
