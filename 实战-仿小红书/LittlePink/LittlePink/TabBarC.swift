//
//  TabBarC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/10.
//

import UIKit
import YPImagePicker
import AVKit

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
            
            // TODO: 判断是否登陆
            
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
            config.maxCameraZoomFactor = kMaxCameraZoomFactor
            
            // MARK: 相册配置
            config.library.onlySquare = false
            config.library.isSquareByDefault = false
            config.library.minWidthForItem = nil
            config.library.mediaType = YPlibraryMediaType.photo
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount
            config.library.minNumberOfItems = kMinPhotoCount
            config.library.numberOfItemsInRow = kNumberOfPhotosInRow
            config.library.spacingBetweenItems = kSpacingBetweenPhotos
            config.library.skipSelectionsGallery = false
            config.library.preselectedItems = nil
            config.library.preSelectItemOnMultipleSelection = true
            
            // MARK: 视频配置
            config.video.compression = AVAssetExportPresetHighestQuality
            config.video.fileType = .mov
            config.video.recordingTimeLimit = 60.0
            config.video.libraryTimeLimit = 60.0
            config.video.minimumTimeLimit = 3.0
            config.video.trimmerMaxDuration = 60.0
            config.video.trimmerMinDuration = 3.0
            
            // MARK: Gallery(多选完后的展示和编辑页面)-画廊
            config.gallery.hidesRemoveButton = false
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                    print("用户按了左上角的取消按钮")
                }
                picker.dismiss(animated: true)
            }
            
            self.present(picker, animated: true)
            
            return false
        }
        
        return true
    }
    
}
