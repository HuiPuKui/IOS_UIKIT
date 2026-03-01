//
//  SettingTableVC-Delegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/1.
//

import Foundation
import Kingfisher
import LeanCloud

extension SettingTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 1, row == 1 {
            // 清除缓存
            ImageCache.default.clearCache {
                self.showTextHUD("清除缓存成功")
                self.cacheSizeLabel.text = kNoCachePH
            }
        } else if section == 3 {
            // TODO: 鼓励一下
            let appID = "当前App的ID"
            // let path = "https://www.baidu.com"
            let path = "https://itunes.apple.com/app/id\(appID)?action=write-review"
            
            guard let url = URL(string: path), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
        } else if section == 4 {
            self.dismiss(animated: true)
            
            LCUser.logOut()
            let loginVC = self.storyboard!.instantiateViewController(identifier: kLoginVCID)
    
            loginAndMeParentVC.removeChildren()
            loginAndMeParentVC.add(child: loginVC)
        }
    }
    
}
