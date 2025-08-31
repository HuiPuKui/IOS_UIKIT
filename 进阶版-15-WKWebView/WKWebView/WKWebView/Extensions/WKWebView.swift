//
//  WKWebView.swift
//  WKWebView
//
//  Created by 惠蒲葵 on 2025/8/31.
//

import UIKit
import WebKit

extension WKWebView {
    
    func load(string: String) {
        if let url = URL(string: string) {
            load(URLRequest(url: url))
        }
    }
    
}
