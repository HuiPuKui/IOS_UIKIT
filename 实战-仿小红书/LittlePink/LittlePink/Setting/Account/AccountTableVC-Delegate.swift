//
//  AccountTableVC-Delegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/1.
//

import Foundation

extension AccountTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                self.showTextHUD("绑定，解绑，换绑手机号")
            }
        }
    }
    
}
