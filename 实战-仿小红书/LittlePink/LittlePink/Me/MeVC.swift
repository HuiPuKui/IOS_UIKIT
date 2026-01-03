//
//  MeVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/13.
//

import UIKit
import LeanCloud


class MeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 去掉返回按钮文字
        self.navigationItem.backButtonDisplayMode = .minimal
    }

    @IBAction func logoutTest(_ sender: Any) {
        LCUser.logOut()
        
        let loginVC = self.storyboard!.instantiateViewController(identifier: kLoginVCID)
        
        loginAndMeParentVC.removeChildren()
        loginAndMeParentVC.add(child: loginVC)
    }

    @IBAction func showDraftNotes(_ sender: Any) {
        let navi = self.storyboard!.instantiateViewController(identifier: kDraftNotesNaviID)
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: true)
    }
    
}
