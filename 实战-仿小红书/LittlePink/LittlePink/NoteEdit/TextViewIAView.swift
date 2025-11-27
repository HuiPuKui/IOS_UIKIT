//
//  TextViewIAView.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/26.
//

import UIKit

class TextViewIAView: UIView {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var textCountStackView: UIStackView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var maxTextCountLabel: UILabel!

    var currentTextCount = 0 {
        didSet {
            if self.currentTextCount <= kMaxNoteTextCount {
                self.doneBtn.isHidden = false
                self.textCountStackView.isHidden = true
            } else {
                self.doneBtn.isHidden = true
                self.textCountStackView.isHidden = false
                
                self.textCountLabel.text = "\(self.currentTextCount)"
            }
        }
    }
    
}
