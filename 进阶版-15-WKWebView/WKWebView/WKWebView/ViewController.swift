//
//  ViewController.swift
//  WKWebView
//
//  Created by 惠蒲葵 on 2025/8/31.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView!
    
    // 自定义根视图
    override func loadView() {
        
        let config = WKWebViewConfiguration()
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.minimumFontSize = 0
        config.preferences = preferences
        
        config.allowsAirPlayForMediaPlayback = true
        config.allowsInlineMediaPlayback = false
        config.allowsPictureInPictureMediaPlayback = true
        
        // 检测所有: 电话号码、地址等
        config.dataDetectorTypes = [.all]
        
        self.webView = WKWebView(frame: .zero, configuration: config)
        self.webView.allowsBackForwardNavigationGestures = true
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.webView.isLoading // 是否正在加载
//        self.webView.reload() // 刷新
//        self.webView.reloadFromOrigin() // 刷新(从源头)
//        self.webView.stopLoading() // 停止加载
//        
//        self.webView.canGoBack // 是否可以后退
//        self.webView.canGoForward // 是否可以下一页
//        self.webView.goBack() // 后退
//        self.webView.goForward() // 下一页
//        
//        self.webView.backForwardList // 访问历史
        
        self.webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
    }

}

