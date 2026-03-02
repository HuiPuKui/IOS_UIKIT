//
//  PasswordLoginVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/26.
//

import UIKit
import LeanCloud

class PasswordLoginVC: UIViewController {

    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    private var phoneNumStr: String {
        return self.phoneNumTF.unwrappedText
    }
    
    private var passwordStr: String {
        return self.passwordTF.unwrappedText
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
    
    @IBAction func backToCodeLoginVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func TFEditChanged(_ sender: Any) {
        if self.phoneNumStr.isPhoneNumber && self.passwordStr.isPassword {
            self.loginBtn.setToEnabled()
        } else {
            self.loginBtn.setToDisabled()
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.view.endEditing(true)
        
        self.showLoadHUD()
        LCUser.logIn(mobilePhoneNumber: self.phoneNumStr, password: self.passwordStr) { result in
            switch result {
            case .success(object: let user):
                self.dismissAndShowMeVC(user)
            case .failure(error: let error):
                self.hideLoadHUD()
                DispatchQueue.main.async {
                    self.showTextHUD("登录失败", true, error.reason)
                }
            }
        }
    }

}

extension PasswordLoginVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let limit = textField == self.phoneNumTF ? 11 : 16
        let isExceed = range.location >= limit || (textField.unwrappedText.count + string.count) > limit
        
        if isExceed {
            self.showTextHUD("最多只能输入\(limit)位哦")
        }
        
        return !isExceed
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.phoneNumTF:
            self.passwordTF.becomeFirstResponder()
        default:
            if self.loginBtn.isEnabled {
                self.login(self.loginBtn)
            }
        }
        return true
    }
    
}
