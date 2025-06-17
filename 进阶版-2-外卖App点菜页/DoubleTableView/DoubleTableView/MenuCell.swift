//
//  MenuCell.swift
//  DoubleTableView
//
//  Created by 惠蒲葵 on 2025/6/17.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var menu: Menu? {
        didSet {
            guard let menu: Menu = self.menu else { return }
            self.menuImageView.image = UIImage(named: menu.menuImageName)
            self.menuNameLabel.text = menu.menuName
            self.priceLabel.text = "¥ \(menu.price)"
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
