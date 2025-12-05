//
//  NoteEditVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/17.
//

import UIKit
import AMapSearchKit
import AMapLocationKit


class NoteEditVC: UIViewController {

    var photos: [UIImage] = []
    
    var videoURL: URL?
//    var videoURL: URL = Bundle.main.url(forResource: "testVideo", withExtension: ".mp4")!
    
    var channel = ""
    var subChannel = ""
    var poiName = ""
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceholderLabel: UILabel!
    
    @IBOutlet weak var poiNameIcon: UIImageView!
    @IBOutlet weak var poiNameLabel: UILabel!
    
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
    
    // TODO: (存草稿和发布笔记之前需判断当前用户输入的正文文本数量，看是否大于最大可输入数量)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC {
            channelVC.PVDelegate = self
        } else if let poiVC = segue.destination as? POIVC {
            poiVC.delegate = self
            poiVC.poiName = self.poiName
        }
    }
    
}

// MARK: - UITextViewDelegate

extension NoteEditVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        // 解决计数问题
        guard self.textView.markedTextRange == nil else { return }
        self.textViewIAView.currentTextCount = textView.text.count
    }
    
}

// MARK: - ChannelVCDelegate

extension NoteEditVC: ChannelVCDelegate {
    
    func updateChannel(channel: String, subChannel: String) {
        // 数据部分
        self.channel = channel
        self.subChannel = subChannel
        
        // UI 部分
        self.channelIcon.tintColor = blueColor
        self.channelLabel.text = self.subChannel
        self.channelLabel.textColor = blueColor
        self.channelPlaceholderLabel.isHidden = true
    }
    
}

// MARK: - POIVCDelegate

extension NoteEditVC: POIVCDelegate {
    
    func updatePOIName(_ poiName: String) {
        if poiName == kPOIsInitArr[0][0] {
            // 数据部分
            self.poiName = ""
            
            // UI 部分
            self.poiNameIcon.tintColor = .label
            self.poiNameLabel.text = "添加地点"
            self.poiNameLabel.textColor = .label
        } else {
            // 数据部分
            self.poiName = poiName
            
            // UI 部分
            self.poiNameIcon.tintColor = blueColor
            self.poiNameLabel.text = self.poiName
            self.poiNameLabel.textColor = blueColor
        }
    }
    
}

// MARK: - UITextFieldDelegate

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
