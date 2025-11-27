//
//  NoteEditVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/17.
//

import UIKit


class NoteEditVC: UIViewController {

    var photos: [UIImage] = []
    
    var videoURL: URL?
//    var videoURL: URL = Bundle.main.url(forResource: "testVideo", withExtension: ".mp4")!
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var photoCount: Int { return photos.count }
    var isVideo: Bool { self.videoURL != nil }
    var textViewIAView: TextViewIAView { return (self.textView.inputAccessoryView as! TextViewIAView) }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
    }

    @IBAction func TFEditBegin(_ sender: Any) {
        self.titleCountLabel.isHidden = false
    }
    
    @IBAction func TFEditEnd(_ sender: Any) {
        self.titleCountLabel.isHidden = true
    }
    
    // 空方法就可以让软键盘消失
    @IBAction func TFEndOnExit(_ sender: Any) {
        
    }
    
    @IBAction func TFEditChanged(_ sender: Any) {
        // 优化系统输入法拼音输入未完成时候计数问题
        guard self.titleTextField.markedTextRange == nil else { return }
        
        if self.titleTextField.unwrappedText.count > kMaxNoteTitleCount {
            self.titleTextField.text = String(self.titleTextField.unwrappedText.prefix(kMaxNoteTitleCount))
            
            self.showTextHUD("标题最多输入\(kMaxNoteTitleCount)字哦")
            
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(
                    from: end,
                    to: end
                )
            }
        }
        
        self.titleCountLabel.text = "\(kMaxNoteTitleCount - self.titleTextField.unwrappedText.count)"
    }
    
}

extension NoteEditVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        // 解决计数问题
        guard self.textView.markedTextRange == nil else { return }
        self.textViewIAView.currentTextCount = textView.text.count
    }
    
}

extension NoteEditVC: UITextFieldDelegate {
    
    /*
     
    // 收起软键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 未处理中文输入计数问题
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let isExceed = range.location >= kMaxNoteTitleCount || (textField.unwrappedText.count + string.count) > kMaxNoteTitleCount
        
        if isExceed {
            self.showTextHUD("标题最多输入\(kMaxNoteTitleCount)字哦")
        }
        
        return !isExceed
    }
     
     */
    
}
