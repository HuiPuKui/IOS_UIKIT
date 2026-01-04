//
//  CustomViews.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/4.
//

import Foundation

@IBDesignable
class BigButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.sharedInit()
    }
    
    private func sharedInit() {
        self.backgroundColor = .secondarySystemBackground
        self.tintColor = .placeholderText
        self.setTitleColor(.placeholderText, for: .normal)
        
        self.contentHorizontalAlignment = .leading
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
}
