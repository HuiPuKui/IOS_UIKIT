//
//  Extensions.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/11.
//

import Foundation

extension Bundle {
    
    var appName: String {
        if let appName = self.localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        } else {
            return self.infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
    
}
