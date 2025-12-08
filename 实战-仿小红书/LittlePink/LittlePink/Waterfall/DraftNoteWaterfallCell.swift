//
//  DraftNoteWaterfallCell.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/8.
//

import UIKit

class DraftNoteWaterfallCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var isVideoImageView: UIImageView!
    
    var draftNote: DraftNote? {
        didSet {
            guard let draftNote = self.draftNote else { return }
            
            let title = draftNote.title!
            self.titleLabel.text = title.isEmpty ? "无题" : title
            
            self.isVideoImageView.isHidden = !draftNote.isVideo
        }
    }
    
}
