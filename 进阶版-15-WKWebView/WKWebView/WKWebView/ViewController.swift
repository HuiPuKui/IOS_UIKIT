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
        
//        let preferences = WKPreferences()
//        preferences.javaScriptEnabled = true
//        preferences.minimumFontSize = 0
//        config.preferences = preferences
//        
//        config.allowsAirPlayForMediaPlayback = true
//        config.allowsInlineMediaPlayback = false
//        config.allowsPictureInPictureMediaPlayback = true
//        
//        // 检测所有: 电话号码、地址等
//        config.dataDetectorTypes = [.all]
        
        self.webView = WKWebView(frame: .zero, configuration: config)
        self.webView.allowsBackForwardNavigationGestures = true
        self.webView.uiDelegate = self
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
        
        self.webView.load("https://www.google.com")
    }

}

extension ViewController: WKUIDelegate {
    
    // @escaping 逃逸: 外围函数执行完毕之后，这个函数并没有被释放
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping @MainActor () -> Void) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            completionHandler() // 将控制权交给 UIKit，如果不点就是什么都不能动的状态
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping @MainActor (Bool) -> Void) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
            completionHandler(false)
        }))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            completionHandler(true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping @MainActor (String?) -> Void) {
        
        let alert = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = defaultText
        }
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            completionHandler(alert.textFields?.last?.text)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}
