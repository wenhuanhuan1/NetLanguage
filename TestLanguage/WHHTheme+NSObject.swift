//
//  WHHTheme+NSObject.swift
//  ThemeTest
//
//  Created by whh on 2022/1/11.
//

import Foundation
import UIKit
var themePickerKey = "themePickerKey"
private var kThemeDeinitBlocks = "kThemeDeinitBlocks"

extension NSObject {
    // 属性字典
    var pickers: [String: Any] {
        if let pickers = objc_getAssociatedObject(self, &themePickerKey) as? [String: Any] {
            return pickers
        } else {
            let pickers = [String: Any]()

            // 释放通知
            if objc_getAssociatedObject(self, &kThemeDeinitBlocks) == nil {
                let deinitHelper = addLanguageDeinitBlock { [weak self] in
                    NotificationCenter.default.removeObserver(self as Any)
                }

                objc_setAssociatedObject(self, &kThemeDeinitBlocks, deinitHelper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }

            NotificationCenter
                .default
                .removeObserver(self, name: WHHLanguageNotification.localizableDidChange, object: nil)
            NotificationCenter
                .default
                .addObserver(self, selector: #selector(themeUpdate), name: WHHLanguageNotification.localizableDidChange, object: nil)
            objc_setAssociatedObject(self, &themePickerKey, pickers, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            return pickers
        }
    }

    // 主题更新通知方法
    @objc func themeUpdate() {
        pickers.forEach({ selectorKey, themeColor in
            let sel: Selector = Selector(selectorKey)
            let key = (themeColor as? String) ?? ""
            let result = WHHLanguageManager.shared.textOf(key: key)
            UIView.animate(withDuration: WHHLanguageModeAnimationDuration, animations: {
                self.perform(sel, with: result)
            })
        })
    }

    /**
     * 注册属性变化
     */
    func register(_ value: String, methodKey: String, dataKey: UnsafeRawPointer) {
        objc_setAssociatedObject(self, dataKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        var pik = pickers
        pik.updateValue(value, forKey: methodKey)
        objc_setAssociatedObject(self, &themePickerKey, pik, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /**
     *
     */
    func language_valueFor(_ dataKey: UnsafeRawPointer) -> String? {
        return objc_getAssociatedObject(self, dataKey) as? String
    }
}
