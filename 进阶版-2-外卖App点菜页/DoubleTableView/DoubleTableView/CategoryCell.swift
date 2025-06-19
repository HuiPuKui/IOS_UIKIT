//
//  CategoryCell.swift
//  DoubleTableView
//
//  Created by 惠蒲葵 on 2025/6/17.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.contentView.backgroundColor = selected ? UIColor.systemBackground : UIColor.clear
        self.categoryLabel.font = selected ? UIFont.boldSystemFont(ofSize: 15) : UIFont.systemFont(ofSize: 15)
        self.categoryLabel.textColor = selected ? UIColor.label : UIColor.secondaryLabel
    }

}
