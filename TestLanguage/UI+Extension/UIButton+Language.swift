//
//  UIButton+Language.swift
//  TestLanguage
//
//  Created by WHH on 2022/1/13.
//

import Foundation
import UIKit

private var buttonTextKey = "buttonTextKey"

extension UIButton {
    func whhSetTitle(_ title: WHHLanguage.Text, forState state: UIControl.State) {
        setTitle(WHHLanguageManager.shared.textOf(key: title.rawValue), for: state)

        var pik = pickers

        var dict: [String: Any] = (pik[String("\(state.rawValue)")] as? [String: Any]) ?? [String: Any]()
        dict.updateValue(title.rawValue, forKey: "setTitle:forState:")
        pik.updateValue(dict, forKey: String("\(state.rawValue)"))

        objc_setAssociatedObject(self, &themePickerKey, pik, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

extension UIButton {
    /// 重写主题更新方法
    @objc override func themeUpdate() {
        pickers.forEach({ key, value in

            if let dict = value as? [String: Any] {
                dict.forEach({ stateKey, selectorValue in

                    let state: UIControl.State = UIControl.State(rawValue: UIControl.State.RawValue(key)!)
                    let selectorStr = (selectorValue as? String) ?? ""

                    UIView.animate(withDuration: WHHLanguageModeAnimationDuration, animations: {
                        
                        if stateKey == "setTitle:forState:" {
                            self.setTitle(WHHLanguageManager.shared.textOf(key: selectorStr), for: state)
                        } else if stateKey == "setBackgroundImage:forState:" {
//                            self.setBackgroundImage(WHHThemeManager.share.imageOf(key: selectorStr), for: state)
                        } else if stateKey == "setImage:forState:" {
//                            self.setImage(WHHThemeManager.share.imageOf(key: selectorStr), for: state)
                        }
                    })
                })
            } else {
                let sel: Selector = Selector(key)
                let valueStr = (value as? String) ?? ""
                let result = WHHLanguageManager.shared.textOf(key: valueStr)

                UIView.animate(withDuration: WHHLanguageModeAnimationDuration, animations: {
                    self.perform(sel, with: result)
                })
            }
        })
    }
}
