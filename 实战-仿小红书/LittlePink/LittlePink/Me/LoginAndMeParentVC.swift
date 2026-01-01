//
//  LoginAndMeParentVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/1.
//

import UIKit
import LeanCloud

var loginAndMeParentVC = UIViewController()

class LoginAndMeParentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = LCApplication.default.currentUser {
            let meVC = self.storyboard!.instantiateViewController(identifier: kMeVCID)
            self.add(child: meVC)
        } else {
            let loginVC = self.storyboard!.instantiateViewController(identifier: kLoginVCID)
            self.add(child: loginVC)
        }
        
        loginAndMeParentVC = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
