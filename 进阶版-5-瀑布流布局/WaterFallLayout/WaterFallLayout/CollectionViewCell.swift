//
//  CollectionViewCell.swift
//  WaterFallLayout
//
//  Created by 惠蒲葵 on 2025/7/6.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 6
    }
}
