//
//  POICell.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/1.
//

import UIKit

class POICell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var poi = ["", ""] {
        didSet {
            self.nameLabel.text = self.poi[0]
            self.addressLabel.text = self.poi[1]
        }
    }
    
}
