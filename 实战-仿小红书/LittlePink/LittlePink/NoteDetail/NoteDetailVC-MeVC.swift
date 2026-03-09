//
//  NoteDetailVC-MeVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/14.
//

import Foundation
import LeanCloud
import Hero

extension NoteDetailVC {
    
    func noteToMeVC(_ user: LCUser?) {
        guard let user = user else { return }
        
        if self.isFromMeVC,
           let fromMeVCUser = self.fromMeVCUser,
           fromMeVCUser == user {
            self.dismiss(animated: true)
        } else {
            let meVC = self.storyboard!.instantiateViewController(identifier: kMeVCID) { coder in
                return MeVC(coder: coder, user: user)
            }
            meVC.isFromNote = true
            meVC.modalPresentationStyle = .fullScreen
            meVC.heroModalAnimationType = .selectBy(
                presenting: .push(direction: .left),
                dismissing: .pull(direction: .right)
            )
            self.present(meVC, animated: true)
        }
    }
    
    @objc func goToMeVC(_ tap: UIPassableTapGestureRecognizer) {
        let user = tap.passObj
        self.noteToMeVC(user)
    }
    
}
