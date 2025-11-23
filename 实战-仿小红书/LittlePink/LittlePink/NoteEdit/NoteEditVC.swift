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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 开启拖放交互
        self.photoCollectionView.dragInteractionEnabled = true
        self.hideKeyboardWithTappedAround()
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
        self.titleCountLabel.text = "\(kMaxNoteTitleCount - self.titleTextField.unwrappedText.count)"
    }
    
}

extension NoteEditVC: UITextFieldDelegate {
    
//    // 收起软键盘
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
}
