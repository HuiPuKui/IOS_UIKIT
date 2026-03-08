//
//  UIView-Extension.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/8.
//

import UIKit

extension UILabel {
    
    func setToLight(_ text: String) {
        self.text = text
        self.textColor = .label
    }
    
}

extension UIButton {
    
    func setToEnabled() {
        self.isEnabled = true
        self.backgroundColor = mainColor
    }
    
    func setToDisabled() {
        self.isEnabled = false
        self.backgroundColor = mainLightColor
    }
    
    func makeCapsule(_ color: UIColor = .label) {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
}

extension UIImage {
    
    // 便利构造器必须调用它直接父类的制定构造器方法
    // 便利构造器必须调用同一个类中定义的其它初始化方法
    // 便利构造器在最后必须调用一个指定构造器
    convenience init?(_ data: Data?) {
        if let unwrappedData = data {
            self.init(data: unwrappedData)
        } else {
            return nil
        }
    }
    
    enum JPEGQuality: CGFloat {
        case lowest = 0
        case low = 0.25
        case mudium = 0.5
        case high = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
}

extension UITextField {
    
    var unwrappedText: String {
        self.text ?? ""
    }
    
    var exactText: String {
        self.unwrappedText.isBlank ? "" : unwrappedText
    }
    
    var isBlank: Bool {
        self.unwrappedText.isBlank
    }
    
}

extension UITextView {
    
    var unwrappedText: String {
        self.text ?? ""
    }
    
    var exactText: String {
        self.unwrappedText.isBlank ? "" : unwrappedText
    }
    
    var isBlank: Bool {
        self.unwrappedText.isBlank
    }
    
}

extension UIView {
    
    @IBInspectable
    var radius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.clipsToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
    
}

extension UIAlertAction {
    
    func setTitleColor(_ color: UIColor) {
        self.setValue(color, forKey: "titleTextColor")
    }
    
    var titleTextColor: UIColor? {
        get {
            self.value(forKey: "titleTextColor") as? UIColor
        }
        set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
    
}
