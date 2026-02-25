//
//  MeVC-EditIntro.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/15.
//

import Foundation

extension MeVC {
    
    @objc func editIntro() {
        let vc = self.storyboard!.instantiateViewController(identifier: kIntroVCID) as! IntroVC
        vc.intro = self.user.getExactStringVal(kIntroCol)
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
}

extension MeVC: IntroVCDelegate {
    
    func updateIntro(_ intro: String) {
        // UI
        self.meHeaderView.introLabel.text = intro.isEmpty ? kIntroPH : intro
        // 云端
        try? self.user.set(kIntroCol, value: intro)
        self.user.save { _ in }
    }
    
}
