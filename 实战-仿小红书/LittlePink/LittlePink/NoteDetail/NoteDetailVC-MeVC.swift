//
//  NoteDetailVC-MeVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/14.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func noteToMeVC(_ user: LCUser?) {
        guard let user = user else { return }
        let meVC = self.storyboard!.instantiateViewController(identifier: kMeVCID) { coder in
            return MeVC(coder: coder, user: user)
        }
        meVC.isFromNote = true
        meVC.modalPresentationStyle = .fullScreen
        self.present(meVC, animated: true)
    }
    
    @objc func goToMeVC(_ tap: UIPassableTapGestureRecognizer) {
        let user = tap.passObj
        self.noteToMeVC(user)
    }
    
}
