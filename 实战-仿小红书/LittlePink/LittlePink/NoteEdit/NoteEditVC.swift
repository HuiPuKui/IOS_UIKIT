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
    
    var draftNote: DraftNote?
    var updateDraftNoteFinished: (() -> ())?

    var photos: [UIImage] = []
    
    var videoURL: URL?
//    var videoURL: URL? = Bundle.main.url(forResource: "TV", withExtension: ".mp4")!
    
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
        self.setUI()
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
        self.handleTFEditChanged()
    }
    
    // TODO: (存草稿和发布笔记之前需判断当前用户输入的正文文本数量，看是否大于最大可输入数量)
    
    @IBAction func saveDraftNote(_ sender: Any) {
            
        guard self.isvVlidateNote() else { return }
        
        if let draftNote = self.draftNote {
            self.updateDraftNote(draftNote)
        } else {
            self.createDraftNote()
        }
        
    }
    
    @IBAction func postNote(_ sender: Any) {
        
        guard self.isvVlidateNote() else { return }
        
        self.createNote()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC {
            self.view.endEditing(true)
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
        self.updateChannelUI()
    }
    
}

// MARK: - POIVCDelegate

extension NoteEditVC: POIVCDelegate {
    
    func updatePOIName(_ poiName: String) {
        // 数据部分
        if poiName == kPOIsInitArr[0][0] {
            self.poiName = ""
        } else {
            self.poiName = poiName
        }
        
        // UI 部分
        self.updatePOINameUI()
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
