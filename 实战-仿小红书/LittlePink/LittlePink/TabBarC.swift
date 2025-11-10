//
//  TabBarC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/10.
//

import UIKit
import YPImagePicker

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
        
        if viewController is PostVC {
            
            let picker = YPImagePicker()
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if let photo = items.singlePhoto {
                    print(photo.fromCamera)
                    print(photo.image)
                    print(photo.originalImage)
                }
                picker.dismiss(animated: true, completion: nil)
            }
            
            self.present(picker, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
}
