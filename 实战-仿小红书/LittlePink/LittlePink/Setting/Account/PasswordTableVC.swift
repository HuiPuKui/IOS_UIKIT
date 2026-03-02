//
//  PasswordTableVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/2.
//

import UIKit

class PasswordTableVC: UITableViewController {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func done(_ sender: Any) {
        
    }
    
    @IBAction func TFEditChanged(_ sender: Any) {
        
    }
    
}

extension PasswordTableVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
}
