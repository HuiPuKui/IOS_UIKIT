//
//  EditProfileTableVC-Delegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/25.
//

import Foundation
import PhotosUI
import ActionSheetPicker_3_0

extension EditProfileTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        
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
            var initialSelection = self.user.getExactBoolValDefaultF(kGenderCol) ? 0 : 1
            if let gender = self.gender {
                initialSelection = gender ? 0 : 1
            }
            let acp = ActionSheetStringPicker(
                title: nil,
                rows: ["男", "女"],
                initialSelection: initialSelection,
                doneBlock: { (_, index, _) in
                    self.gender = index == 0
                },
                cancel: { _ in },
                origin: cell
            )
                
            acp?.show()
        default:
            break
        }
    }
    
}
