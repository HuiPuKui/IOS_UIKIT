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
    var phoneNum: String? {
        return self.user.mobilePhoneNumber?.value
    }

    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var appleIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let phoneNum = self.phoneNum {
            self.phoneNumLabel.text = phoneNum
        }
    }

}
