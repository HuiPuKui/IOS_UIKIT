//
//  AccountTableVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/1.
//

import UIKit
import LeanCloud

class AccountTableVC: UITableViewController {
    
    var user: LCUser!
    var phoneNumStr: String? {
        return self.user.mobilePhoneNumber?.value
    }
    var isSetPassword: Bool? {
        return self.user.get(kIsSetPasswordCol)?.boolValue
    }

    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var appleIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let phoneNum = self.phoneNumStr {
            self.phoneNumLabel.setToLight(phoneNum)
        }
        
        if let _ = self.isSetPassword {
            self.passwordLabel.setToLight("已设置")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passwordTableVC = segue.destination as? PasswordTableVC {
            passwordTableVC.user = self.user
            if self.isSetPassword == nil {
                passwordTableVC.setPasswordFinished = {
                    self.passwordLabel.setToLight("已设置")
                }
            }
        }
    }

}
