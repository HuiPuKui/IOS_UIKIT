//
//  LC-Extension.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/31.
//

import Foundation
import LeanCloud

extension LCFile {
    
    func save(to table: LCObject, as record: String) {
        self.save { result in
            switch result {
            case .success:
                if let value = self.objectId?.value {
//                    print("文件保存完成。objectId: \(value)")
                    do {
                        try table.set(record, value: self)
                        table.save { result in
                            switch result {
                            case .success:
//                                print("文件已关联")
                                break 
                            case .failure(error: let error):
                                print("保存表的数据失败: \(error)")
                            }
                        }
                    } catch {
                        print("给 User 表的字段赋值失效: \(error)")
                    }
                }
            case .failure(error: let error):
                print("保存文件进云端失败: \(error)")
            }
        }
    }
    
}
