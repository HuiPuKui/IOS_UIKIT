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
    var spinner: UIActivityIndicatorView!
    
    // 自定义根视图
    override func loadView() {
        
        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: "user")
//        // web 发送方式
//        <script type="text/javascript">
//            function sendMessageToiOS() {
//                var lebus = {
//                    name: "lebus",
//                    age: 20
//                };
//                window.webkit.messageHandlers.user.postMessage(lebus)
//            }
//        </script>
        
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
        self.webView.navigationDelegate = self
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSpinner()
        
        // 加载自己的 HTML 代码
//        handleHTMLString()
        // 加载自己的文件
//        handleHTMLFile()

        
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
        
        // 添加加载进度的观察者
        self.webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil
        )
    }
    
    func setSpinner() {
        self.spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.spinner.color = .white
        self.spinner.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.spinner.layer.cornerRadius = 10
        self.webView.addSubview(self.spinner)
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.centerXAnchor.constraint(equalTo: self.webView.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: self.webView.centerYAnchor).isActive = true
        self.spinner.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.spinner.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func handleHTMLString() {
        let html = """
        <!DOCTYPE html>
        <html>
            <head>
                <meta charset="UTF-8">
                <title>Lebus</title>
            </head>
            <body>
                <div style="text-align: center; font-size: 80px; margin-top: 350px">Lebus的iOS教程</div>
            </body>
        </html>
        """
        self.webView.loadHTMLString(html, baseURL: nil)
//        self.webView.loadHTMLString(html, baseURL: Bundle.main.resourceURL) // 加载 Xcode 工程中的图片
    }
    
    func handleHTMLFile() {
        let url = Bundle.main.url(forResource: "HomePage", withExtension: "html")!
        print(url)
        self.webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
    
    func handleJS() {
        self.webView.evaluateJavaScript("document.body.offsetHeight") { (res, error) in
            print(res ?? 0)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            print(self.webView.estimatedProgress)
        }
    }
    
    deinit {
        // 移除观察者
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }

}

extension ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "user" {
            print(message.body)
        }
    }
    
}

extension ViewController: WKNavigationDelegate {
    
    // 决定要不要加载
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
        print(#function)
        if let url = navigationAction.request.url {
            if url.host == "www.google.comm" { // 让谷歌旗下的全都从外部打开
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    // 开始请求
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        self.spinner.startAnimating()
    }
    
    // 是否接收响应
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping @MainActor (WKNavigationResponsePolicy) -> Void) {
        print(#function)
        if let httpResponse = navigationResponse.response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                decisionHandler(.allow)
            } else {
                decisionHandler(.cancel)
            }
        } else {
            // 本地文件 or 非 HTTP 响应 → 一律放行
            decisionHandler(.allow)
        }
    }
    
    // 服务器端开始返回内容
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
    }
    
    // 加载完毕
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        self.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
        
        // 加载自己的 JS
        handleJS()
    }
    
    // 加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        print(#function)
        self.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
    }
    
}

extension ViewController: WKUIDelegate {
    
    // @escaping 逃逸: 外围函数执行完毕之后，这个函数并没有被释放
    // [js]alert() 警告框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping @MainActor () -> Void) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            completionHandler() // 将控制权交给 UIKit，如果不点就是什么都不能动的状态
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    // [js]confirm() 弹出框
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
    
    // [js]prompt() 输入框
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

