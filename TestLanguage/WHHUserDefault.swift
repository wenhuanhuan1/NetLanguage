//
//  WHHUserDefault.swift
//  ThemeTest
//
//  Created by whh on 2022/1/11.
// UserDefault保存类

import Foundation

extension UserDefaults {
    static func whh_objectForKey(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    static func whh_setAndSaveObject(_ value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func whh_removeObjectForKey(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
