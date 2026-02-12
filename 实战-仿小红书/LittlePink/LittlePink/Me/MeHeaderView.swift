//
//  MeHeaderView.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/11.
//

import UIKit

class MeHeaderView: UIView {
    @IBOutlet weak var rootStackView: UIStackView!
    @IBOutlet weak var editOrFollowBtn: UIButton!
    @IBOutlet weak var settingOrChatBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.editOrFollowBtn.makeCapsule()
        self.settingOrChatBtn.makeCapsule()
    }

}
