//
//  MyDraftNoteWaterfallCell.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/23.
//

import UIKit

class MyDraftNoteWaterfallCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.countLabel.text = "\(UserDefaults.standard.integer(forKey: kDraftNoteCount))"
    }

}
