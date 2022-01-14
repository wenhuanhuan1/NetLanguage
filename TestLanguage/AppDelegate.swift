//
//  AppDelegate.swift
//  TestLanguage
//
//  Created by WHH on 2022/1/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        /// 获取系统语言
//        let user = UserDefaults.standard.object(forKey: "AppleLanguages")
//        print(user as Any)
//        print(WHHLanguageManager.shared.getSystemLanguage())
        WHHLanguageManager.shared.initLanguage()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }
}
