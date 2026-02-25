//
//  IntroVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/25.
//

import UIKit

class IntroVC: UIViewController {

    var intro: String = ""
    var delegate: IntroVCDelegate?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView.becomeFirstResponder()
        self.textView.text = self.intro
        self.countLabel.text = "\(kMaxIntroCount)"
    }
    
    @IBAction func done(_ sender: Any) {
        delegate?.updateIntro(self.textView.exactText)
        self.dismiss(animated: true)
    }

}

extension IntroVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        // 解决计数问题
        guard self.textView.markedTextRange == nil else { return }
        self.countLabel.text = "\(kMaxIntroCount - self.textView.text.count)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let isExceed = range.location >= kMaxIntroCount || (textView.text.count + text.count > kMaxIntroCount)
        if isExceed {
            self.showTextHUD("个人简介最多输入\(kMaxIntroCount)字哦")
        }
        return !isExceed
    }
    
}
