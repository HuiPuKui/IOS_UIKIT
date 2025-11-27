//
//  Extensions.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/11.
//

import UIKit

extension UITextField {
    
    var unwrappedText: String {
        self.text ?? ""
    }
    
}

extension UIView {
    
    @IBInspectable
    var radius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}

extension UIViewController {
    
    // MARK: - 展示加载框或提示框
    
    // MARK: - 加载框 -- 手动隐藏
    
    // MARK: - 提示框 -- 自动隐藏
    
    func showTextHUD(_ title: String, _ subTitle: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .text // 不指定的话显示菊花和下面配置的文本
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func hideKeyboardWithTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dissmissKeyboard() {
        self.view.endEditing(true)
    }
    
}

extension Bundle {
    
    var appName: String {
        if let appName = self.localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        } else {
            return self.infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
    
    // static 能修饰 class/struct/enum 的计算属性、存储属性、类型方法；class 能修饰类的计算属性和类方法
    // static 修饰的类方法不能继承；class 修饰的类方法可以继承
    // 在 protocol 中要使用 static
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("加载 \(type) 类型的 view 失败")
    }
    
}
