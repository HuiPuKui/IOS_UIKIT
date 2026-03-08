//
//  VC-Extension.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/8.
//

import Foundation

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
    
    func showLoginHUD() {
        self.showTextHUD("请先登录哦")
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
