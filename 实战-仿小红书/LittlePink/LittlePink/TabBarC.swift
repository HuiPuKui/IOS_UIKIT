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
            
            var config = YPImagePickerConfiguration()
            
            // MARK: 通用配置
            config.isScrollToChangeModesEnabled = false
            config.onlySquareImagesFromCamera = false
            config.albumName = Bundle.main.appName
            
            config.startOnScreen = .library
            config.screens = [.library, .video, .photo]
            
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.hidesCancelButton = false
            
            config.preferredStatusBarStyle = UIStatusBarStyle.default
            config.maxCameraZoomFactor = 5.0
            
            config.library.preSelectItemOnMultipleSelection = true
            
            let picker = YPImagePicker(configuration: config)
            
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
