//
//  Extensions.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/11.
//

import UIKit
import DateToolsSwift

extension String {
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}

extension Optional where Wrapped == String {
    
    var unwrappedText: String { self ?? "" }
    
}

extension Date {
    
    // 本项目 5 种时间表示方式:
    // 1. 刚刚/5分钟前; 2.今天21:10; 3.昨天21:10; 4.09-15; 5.2019-09-15
    var formattedDate: String {
        let currentYear = Date().year
        
        if self.year == currentYear { // 今年
            
            if self.isToday {
                if self.minutesAgo > 10 {
                    return "今天 \(self.format(with: "HH-mm"))"
                } else {
                    return self.timeAgoSinceNow
                }
            } else if self.isYesterday {
                return "昨天 \(self.format(with: "HH-mm"))"
            } else {
                return self.format(with: "MM-dd")
            }
        } else if self.year < currentYear { // 去年或更早
            return self.format(with: "yyyy-MM-dd")
        } else {
            return "明年或更远,目前项目暂不会用到"
        }
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
    
}

extension UITextView {
    
    var unwrappedText: String {
        self.text ?? ""
    }
    
    var exactText: String {
        self.unwrappedText.isBlank ? "" : unwrappedText
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
    
    func showLoadHUD(_ title: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = title
    }
    
    func hideLoadHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
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
