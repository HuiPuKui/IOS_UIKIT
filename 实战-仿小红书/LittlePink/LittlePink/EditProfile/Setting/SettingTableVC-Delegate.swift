//
//  SettingTableVC-Delegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/1.
//

import Foundation
import Kingfisher

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
        }
    }
    
}
