//
//  RoundedLabel.swift
//  PeopleOcclusion
//
//  Created by 刘军 on 2020/3/22.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedLabel: UILabel {

    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)))
    }
    
    func displayMessage(_ text: String, _ duration: TimeInterval){
        self.isHidden = false
        self.text = text
        
        let tag = self.tag + 1 //flag--用户每点一次都会加1
        self.tag = tag
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            //判断当前排队中（queue）的self.tag是否是最新的
            if self.tag == tag{
                self.isHidden = true
            }
        }
    }

}
