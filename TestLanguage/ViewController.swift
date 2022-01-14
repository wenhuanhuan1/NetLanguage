//
//  ViewController.swift
//  TestLanguage
//
//  Created by WHH on 2022/1/12.
//

import UIKit

class ViewController: UIViewController {
    var num = 0
    var nameLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.textColor = .blue
        nameLabel.whhText = WHHLanguage.Text.nameText
        view.addSubview(nameLabel)

        let loginBtn = UIButton(type: .custom)
        loginBtn
            .frame = CGRect(x: (UIScreen.main.bounds.width - 200) / 2, y: 200, width: 200, height: 50)
        loginBtn.backgroundColor = .red
        loginBtn.whhSetTitle(WHHLanguage.Text.loginBtnText, forState: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginBtn.setTitleColor(.white, for: .normal)
        view.addSubview(loginBtn)
        navigationItem.whhTitle = WHHLanguage.Text.navigationTitle
        let inpute = UITextField(frame: CGRect(x: 20, y: 270, width: 240, height: 30))
        inpute.whhPlaceHolder = WHHLanguage.Text.placeholderText
        inpute.backgroundColor = .red
        view.addSubview(inpute)
        let textView = UITextView(frame: CGRect(x: 20, y: 320, width: 250, height: 200))
        textView.whhText = WHHLanguage.Text.textViewText
        textView.backgroundColor = .blue
        view.addSubview(textView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        num += 1
        if num == 1 {
            WHHLanguageManager.shared.configLanguage("CH")

        } else {
            num = 0
            WHHLanguageManager.shared.configLanguage("en-US")
        }
    }
}
