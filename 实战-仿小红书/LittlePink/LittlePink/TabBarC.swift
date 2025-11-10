//
//  TabBarC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/10.
//

import UIKit

class TabBarC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

}

extension TabBarC: UITabBarControllerDelegate {
    
    // true - 常规展示
    // false - 自定义展示
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if let vc = viewController as? PostVC {
            
            
            
            return false
        }
        
        return true
    }
    
}
