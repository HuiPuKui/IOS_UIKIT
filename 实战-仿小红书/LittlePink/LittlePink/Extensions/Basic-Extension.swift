//
//  Basic-Extension.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/8.
//

import Foundation
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
    
    var isPassword: Bool {
        return NSRegularExpression(kPasswordRegEx).matches(self)
    }
    
    static func randomString(_ length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    func spliceAttrStr(_ dateStr: String) -> NSMutableAttributedString {
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

extension UserDefaults {
    
    static func increase(_ key: String, by value: Int = 1) {
        self.standard.set(self.standard.integer(forKey: key) + value, forKey: key)
    }
    
    static func decrease(_ key: String, by value: Int = 1) {
        self.standard.set(self.standard.integer(forKey: key) - value, forKey: key)
    }
    
}
