//
//  WHHLanguageManager.swift
//  TestLanguage
//
//  Created by WHH on 2022/1/12.
// 本地语言切换

import Foundation
import UserNotifications
let WHHLanguageModeAnimationDuration = 0.5
struct WHHLanguageNotification {
    // 语言环境切换通知
    static let localizableDidChange = NSNotification.Name(rawValue: "WHHLanguage.localizableDidChange")
}

enum WHHLanguage: String {
    case languageType
    enum Text: String {
        case nameText
        case addressText
        case loginBtnText
        case setText
        case navigationTitle
        case placeholderText
        case textViewText
    }
}

class WHHLanguageManager: NSObject {
    /// 语言偏好存储
    static let whhLanguageSaveKey = "whhLanguageSaveKey"

    static let whhNotificationLanguageNameKey = "whhNotificationLanguageNameKey"

    // 当前语言
    var currentLanguage: String = ""
    /// 保存配置文件中的语言字典
    var languageDict: [String: Any] = [:]
    // 单利创建
    static let shared: WHHLanguageManager = WHHLanguageManager()

    override init() {
        super.init()
        analysisRequestData()
    }

    /// 解析当前请求网络语言数据库
    private func analysisRequestData() {
        if let path = Bundle.main.path(forResource: "Language", ofType: "plist"),
           let language = NSDictionary(contentsOfFile: path) as? [String: Any] {
            languageDict = language
        }
    }

    // MARK: 默认初始化为系统语言

    func initLanguage() {
        if let saveLanguage = UserDefaults
            .whh_objectForKey(WHHLanguageManager.whhLanguageSaveKey) as? String {
            // 说明用户之前设置过本地语言
            currentLanguage = saveLanguage
            setCurrentLanguage(currentLanguage)

        } else {
            // 用户没有设置过
            if let languageString = getSystemLanguage() {
                currentLanguage = languageString
                setCurrentLanguage(currentLanguage)
            }
        }
    }

    /// 设置当前语言
    func configLanguage(_ type: String) {
        currentLanguage = type
        // 存储当前主题
        UserDefaults.whh_setAndSaveObject(currentLanguage, key: WHHLanguageManager.whhLanguageSaveKey)
        /// 用户在APP设置过语言
        setCurrentLanguage(currentLanguage)
    }

    /// 得到对应的
    func textOf(key: String) -> String {
        if let text = (languageDict[currentLanguage] as? [String: Any])?[key] {
            if let temp = text as? String {
                return temp
            }
        }
        return "😁"
    }

    /// 设置当前语言发送通知
    private func setCurrentLanguage(_ language: String) {
        /// 发送修改语言的通知

        NotificationCenter.default.post(name: WHHLanguageNotification.localizableDidChange, object: nil)
    }

    // MARK: 获取系统当前语言名字

    func getSystemLanguage() -> String? {
        let appLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        return appLanguages?.first
    }
}
