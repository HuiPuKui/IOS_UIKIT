//
//  PasswordTableVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/2.
//

import UIKit
import LeanCloud

class PasswordTableVC: UITableViewController {

    var user: LCUser!
    var setPasswordFinished: (() -> ())?
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    private var passwordStr: String {
        return self.passwordTF.unwrappedText
    }
    
    private var confirmPasswordStr: String {
        return self.confirmPasswordTF.unwrappedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.passwordTF.becomeFirstResponder()
    }

    @IBAction func done(_ sender: UIButton) {
        if self.passwordStr.isPassword && self.confirmPasswordStr.isPassword {
            if self.passwordStr == self.confirmPasswordStr {
                // 云端
                self.user.password = LCString(self.passwordStr)
                try? self.user.set(kIsSetPasswordCol, value: true)
                self.user.save { _ in }
                
                // UI
                self.dismiss(animated: true)
                self.setPasswordFinished?()
            } else {
                self.showTextHUD("两次密码不一致")
            }
        } else {
            self.showTextHUD("密码必须为6-16位的数字或字母")
        }
    }
    
    @IBAction func TFEditChanged(_ sender: Any) {
        if self.passwordTF.isBlank || self.confirmPasswordTF.isBlank {
            self.doneBtn.isEnabled = false
        } else {
            self.doneBtn.isEnabled = true
        }
    }
    
}

extension PasswordTableVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.passwordTF:
            self.confirmPasswordTF.becomeFirstResponder()
        default:
            if self.doneBtn.isEnabled {
                self.done(self.doneBtn)
            }
        }
        return true
    }
    
}
