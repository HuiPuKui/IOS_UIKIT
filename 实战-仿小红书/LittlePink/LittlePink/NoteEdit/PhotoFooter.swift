//
//  PhotoFooter.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/19.
//

import UIKit

class PhotoFooter: UICollectionReusableView {

    @IBOutlet weak var addPhotoBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addPhotoBtn.layer.borderWidth = 1
        self.addPhotoBtn.layer.borderColor = UIColor.tertiaryLabel.cgColor
    }
    
}
