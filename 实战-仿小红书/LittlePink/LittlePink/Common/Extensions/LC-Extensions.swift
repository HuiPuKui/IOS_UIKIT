//
//  LC-Extension.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/31.
//

import Foundation
import LeanCloud

extension LCFile {
    
    func save(to table: LCObject, as record: String, group: DispatchGroup? = nil) {
        group?.enter()
        self.save { result in
            switch result {
            case .success:
                if let value = self.objectId?.value {
//                    print("文件保存完成。objectId: \(value)")
                    do {
                        try table.set(record, value: self)
                        group?.enter()
                        table.save { result in
                            switch result {
                            case .success:
//                                print("文件已关联/文件已存入\(record)字段")
                                break 
                            case .failure(error: let error):
                                print("保存表的数据失败: \(error)")
                            }
                            group?.leave()
                        }
                    } catch {
                        print("给 User 表的字段赋值失效: \(error)")
                    }
                }
            case .failure(error: let error):
                print("保存文件进云端失败: \(error)")
            }
            group?.leave()
        }
    }
    
}

extension LCObject {
    
    func getExactStringVal(_ col: String) -> String {
        return self.get(col)?.stringValue ?? ""
    }
    
    func getExactIntVal(_ col: String) -> Int {
        return self.get(col)?.intValue ?? 0
    }
    
    func getExactDoubleVal(_ col: String) -> Double {
        return self.get(col)?.doubleValue ?? 1
    }
    
    func getExactBoolValDefaultF(_ col: String) -> Bool {
        return self.get(col)?.boolValue ?? false
    }
    
    func getExactBoolValDefaultT(_ col: String) -> Bool {
        return self.get(col)?.boolValue ?? true
    }
    
    enum imageType {
        case avatar
        case coverPhoto
    }
    
    func getImageURL(from col: String, _ type: imageType) -> URL {
        if let file = self.get(col) as? LCFile,
           let path = file.url?.stringValue,
           let url = URL(string: path) {
            return url
        } else {
            switch type {
            case .avatar:
                return Bundle.main.url(forResource: "avatarPH", withExtension: ".jpeg")!
            case .coverPhoto:
                return Bundle.main.url(forResource: "imagePH", withExtension: ".png")!
            }
        }
    }
    
    static func userInfo(where userObjectId: String, increase col: String) {
        let query = LCQuery(className: kUserInfoTable)
        query.whereKey(kUserObjectIdCol, .equalTo(userObjectId))
        query.getFirst { res in
            if case let .success(object: userInfo) = res {
                try? userInfo.increase(col)
            }
        }
    }
    
    static func userInfo(where userObjectId: String, decrease col: String, to: Int) {
        let query = LCQuery(className: kUserInfoTable)
        query.whereKey(kUserObjectIdCol, .equalTo(userObjectId))
        query.getFirst { res in
            if case let .success(object: userInfo) = res {
                try? userInfo.set(col, value: to)
                userInfo.save { _ in }
            }
        }
    }
    
}
