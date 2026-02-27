//
//  EditProfileTableVC-Delegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/25.
//

import Foundation
import PhotosUI
import ActionSheetPicker_3_0
import DateToolsSwift

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
            let acp = ActionSheetStringPicker(
                title: nil,
                rows: ["男", "女"],
                initialSelection: self.gender ? 0 : 1,
                doneBlock: { (_, index, _) in
                    self.gender = index == 0
                },
                cancel: { _ in },
                origin: cell
            )
                
            acp?.show()
        case 3:
            var selectedDate = Date().subtract(TimeChunk(
                seconds: 0,
                minutes: 0,
                hours: 0,
                days: 0,
                weeks: 0,
                months: 0,
                years: 20
            ))
            
            if let birth = self.birth {
                selectedDate = birth
            } else if let birth = user.get(kBirthCol)?.dateValue {
                selectedDate = birth
            }
            
            let datePicker = ActionSheetDatePicker(
                title: nil,
                datePickerMode: .date,
                selectedDate: selectedDate,
                doneBlock: { (_, date, _) in
                    self.birth = date as? Date
                },
                cancel: { _ in },
                origin: cell
            )
            
            datePicker?.minimumDate = Date().subtract(TimeChunk(
                seconds: 0,
                minutes: 0,
                hours: 0,
                days: 0,
                weeks: 0,
                months: 0,
                years: 40
            ))
            datePicker?.maximumDate = Date()
            
            datePicker?.show()
        case 4:
            let vc = self.storyboard!.instantiateViewController(identifier: kIntroVCID) as! IntroVC
            vc.intro = self.user.getExactStringVal(kIntroCol)
            vc.delegate = self
            self.present(vc, animated: true)
        default:
            break
        }
    }
    
}

extension EditProfileTableVC: IntroVCDelegate {
    
    func updateIntro(_ intro: String) {
        self.intro = intro
    }
    
}
