//
//  POICell.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/1.
//

import UIKit

class POICell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var poi = ["", ""] {
        didSet {
            self.titleLabel.text = self.poi[0]
            self.addressLabel.text = self.poi[1]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
