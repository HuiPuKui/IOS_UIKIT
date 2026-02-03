//
//  Extensions.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/11.
//

import UIKit
import AVFoundation
import DateToolsSwift

extension Int {
    
    var formattedStr: String {
        let num = Double(self)
        let tenThousand = num / 10_000
        let hundredMillion = num / 100_000_000
        
        if tenThousand < 1 {
            return "\(self)"
        } else if hundredMillion >= 1 {
            return "\(round(hundredMillion * 10) / 10)亿)"
        } else {
            return "\(round(tenThousand * 10) / 10)万"
        }
    }
    
}

extension String {
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isPhoneNumber: Bool {
        return Int(self) != nil && NSRegularExpression(kPhoneRegEx).matches(self)
    }
    
    var isAuthCode: Bool {
        return Int(self) != nil && NSRegularExpression(kAuthCodeRegEx).matches(self)
    }
    
    static func randomString(_ length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    func spliceAttrStr(_ dateStr: String) -> NSAttributedString {
        let attrText = self.toAttrStr()
        let attrDate = " \(dateStr)".toAttrStr(12, .secondaryLabel)
        
        attrText.append(attrDate)
        return attrText
    }
    
    func toAttrStr(_ fontSize: CGFloat = 14, _ color: UIColor = .label) -> NSMutableAttributedString {
        let attr: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: color
        ]
        return NSMutableAttributedString(string: self, attributes: attr)
    }
    
}

extension NSRegularExpression {
    
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            fatalError("非法的正则表达式")
        }
    }
    
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
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
                    return "今天 \(self.format(with: "HH:mm"))"
                } else {
                    return self.timeAgoSinceNow
                }
            } else if self.isYesterday {
                return "昨天 \(self.format(with: "HH:mm"))"
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

extension URL {
    
    var thumbnail: UIImage {
        let asset = AVAsset(url: self)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            return imagePH
        }
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
    
    func showTextHUD(_ title: String, _ inCurrentView: Bool = true, _ subTitle: String? = nil) {
        var viewToShow = self.view!
        if !inCurrentView {
            viewToShow = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: viewToShow, animated: true)
        hud.mode = .text // 不指定的话显示菊花和下面配置的文本
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    // 用于在本 vc 调用，让他显示到别的 vc （如父 vc） 里去
    func showTextHUD(_ title: String, in view: UIView, _ subTitle: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
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
    
    func add(child vc: UIViewController) {
        self.addChild(vc)
        vc.view.frame = view.bounds
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func remove(child vc: UIViewController) {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    func removeChildren() {
        if !self.children.isEmpty {
            for vc in self.children {
                self.remove(child: vc)
            }
        }
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

extension FileManager {
    
    func save(_ data: Data?, to dirName: String, as fileName: String) -> URL? {
        guard let data = data else {
            print("要写入本地的 data 为 nil")
            return nil
        }
        
        // "file:///xx/xx/tmp/dirName"
        let dirURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(dirName, isDirectory: true)
        
        if !self.fileExists(atPath: dirURL.path) {
            guard let _ = try? self.createDirectory(at: dirURL, withIntermediateDirectories: true) else {
                print("创建文件夹失败")
                return nil
            }
        }
        
        // "file:///xx/xx/tmp/dirName/fileName"
        let fileURL = dirURL.appendingPathComponent(fileName)
        
        if !self.fileExists(atPath: fileURL.path) {
            guard let _ = try? data.write(to: fileURL) else {
                print("写入/保存文件失败")
                return nil
            }
        }
        
        return fileURL
    }
    
}
