//
//  EditProfileTableVC-Delegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/25.
//

import Foundation
import PhotosUI

extension EditProfileTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            var config = PHPickerConfiguration()
            config.filter = .images
            config.selectionLimit = 1
            
            let vc = PHPickerViewController(configuration: config)
            vc.delegate = self
            
            self.present(vc, animated: true)
        case 1:
            self.showTextHUD("修改昵称，和修改简介一样")
        case 2:
            
        default:
            break
        }
    }
    
}
