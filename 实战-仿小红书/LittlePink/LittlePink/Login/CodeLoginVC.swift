//
//  CodeLoginVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/26.
//

import UIKit

class CodeLoginVC: UIViewController {

    @IBOutlet weak var phoneNumTF: UITextField!
    
    @IBOutlet weak var authCodeTF: UITextField!
    
    @IBOutlet weak var getAuthCodeBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
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
    
    @IBAction func getAuthCode(_ sender: Any) {
        
    }
    
    @IBAction func login(_ sender: Any) {
        
    }

}
