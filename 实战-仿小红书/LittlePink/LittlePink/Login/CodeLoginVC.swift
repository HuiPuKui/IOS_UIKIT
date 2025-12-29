//
//  CodeLoginVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/26.
//

import UIKit
import LeanCloud

private let totalTime = 60

class CodeLoginVC: UIViewController {

    private var timeRemain = totalTime
    
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var authCodeTF: UITextField!
    @IBOutlet weak var getAuthCodeBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    lazy private var timer = Timer()
    
    private var phoneNumStr: String {
        return self.phoneNumTF.unwrappedText
    }
    
    private var authCodeStr: String {
        return self.authCodeTF.unwrappedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWithTappedAround()
        
        self.loginBtn.setToDisabled()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.phoneNumTF.becomeFirstResponder()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func TFEditingChanged(_ sender: UITextField) {
        if sender == self.phoneNumTF {
            self.getAuthCodeBtn.isHidden = !self.phoneNumStr.isPhoneNumber && self.getAuthCodeBtn.isEnabled
        }
        
        if self.phoneNumStr.isPhoneNumber && self.authCodeStr.isAuthCode {
            self.loginBtn.setToEnabled()
        } else {
            self.loginBtn.setToDisabled()
        }
    }
    
    @IBAction func getAuthCode(_ sender: Any) {
        self.getAuthCodeBtn.isEnabled = false
        self.setAuthCodeBtnDisabledText()
        self.authCodeTF.becomeFirstResponder()
        
        self.timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(changeAuthCodeBtnText),
            userInfo: nil,
            repeats: true
        )
        
        let varibles: LCDictionary = [
            "name": LCString("小粉书"),
            "ttl": LCNumber(5)
        ]
        
        LCSMSClient.requestShortMessage(
            mobilePhoneNumber: self.phoneNumStr,
            templateName: "login",
            signatureName: "小粉书",
            variables: varibles
        ) { result in
            if case let .failure(error: error) = result{
                print(error.reason ?? "短信验证码未知错误")
            }
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
    }

}

extension CodeLoginVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let limit = textField == self.phoneNumTF ? 11 : 6
        let isExceed = range.location >= limit || (textField.unwrappedText.count + string.count) > limit
        
        if isExceed {
            self.showTextHUD("最多只能输入\(limit)位哦")
        }
        
        return !isExceed
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.phoneNumTF {
            self.authCodeTF.becomeFirstResponder()
        } else {
            if self.loginBtn.isEnabled {
                self.login(self.loginBtn)
            }
        }
        
        return true
    }
    
}

extension CodeLoginVC {
    
    @objc func changeAuthCodeBtnText() {
        self.timeRemain -= 1
        self.setAuthCodeBtnDisabledText()
        
        if self.timeRemain <= 0 {
            self.timer.invalidate()
            self.timeRemain = totalTime
            self.getAuthCodeBtn.isEnabled = true
            self.getAuthCodeBtn.setTitle("发送验证码", for: .normal)
            
            self.getAuthCodeBtn.isHidden = !phoneNumStr.isPhoneNumber // 如果用户输入的手机号不是合法手机号就再次隐藏掉
        }
    }
    
}

extension CodeLoginVC {
    
    private func setAuthCodeBtnDisabledText() {
        self.getAuthCodeBtn.setTitle("重新发送(\(self.timeRemain)s)", for: .disabled)
    }
    
}
