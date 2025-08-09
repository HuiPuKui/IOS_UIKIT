//
//  TabBarController.swift
//  TaoBaoTabBarController
//
//  Created by 惠蒲葵 on 2025/8/9.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.delegate = self
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = .label
        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .light)
        ]
        
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .medium)
        ]
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let items = tabBar.items!
        let homeTabBatItem = items[0]
        
        // 获取用户点击的是第几个 item 类型 Array<UITabBarItem>.Index -> Int
        let index = items.firstIndex(of: item)!
        
        if index == 0 {
            homeTabBatItem.title = nil
            homeTabBatItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        } else {
            homeTabBatItem.title = "首页"
            homeTabBatItem.imageInsets = UIEdgeInsets.zero
        }
    }
    
    // 与上同理
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let homeVC = self.viewControllers![0]
        
        if viewController == homeVC {
            homeVC.tabBarItem.title = nil
            homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        } else {
            homeVC.tabBarItem.title = "首页"
            homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

}
