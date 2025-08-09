//
//  ViewController.swift
//  WeChatTabbarController
//
//  Created by 惠蒲葵 on 2025/8/6.
//

import UIKit

class ViewController: UIViewController {

    // iOS 15，tabbar 背景色问题（navigationbar也差不多）
    
    // 旧版: tabbar 的默认样式为毛玻璃效果（磨砂玻璃，不是完全的不透名，能隐约看到下面视图的内容，也有类似马赛克）
    
    // 新版:
    // 1. 非 scrollview（微信vc），是 scrollview 但里面内容没有和 tabbar 重叠时（发现vc）
    // 此时系统将使用 tabbar 的 scrollEdgeAppearance 属性配置 tabbar 的样式，而 scrollEdgeAppearance 属性默认是 nil，即透明色
    // 也就是说，这些时候，如果需要背景色或毛玻璃效果，则需要设置 tabbar 的 scrollEdgeAppearance 属性
    
    // 2. scrollview 里面内容和 tabbar 重叠时（通讯录vc）
    // 当 scrollview 里的内容滑动到和 tabbar 重叠的时候（无论是自然滑动，还是到达边缘后通过 bounce 效果的滑动），
    // 将使用 tabbar 的 standardAppearance 属性配置 tabbar 的样式，而 standardAppearance 属性默认是毛玻璃效果
    
    // 很容易混乱，故现阶段比较建议大家两个属性都点上，并设计成一样的（比如 standardAppearance 设背景色为橙色，scrollEdgeAppearance 的背景色也设为橙色）
    // 比如，我这边都让他是一个默认的毛玻璃
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
}

