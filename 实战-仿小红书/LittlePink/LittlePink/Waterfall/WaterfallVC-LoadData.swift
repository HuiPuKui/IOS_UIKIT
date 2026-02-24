//
//  WaterfallVC-LoadData.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/9.
//

import CoreData
import Foundation
import LeanCloud

extension WaterfallVC {
    
    func getDraftNotes() {
        let request = DraftNote.fetchRequest() as NSFetchRequest<DraftNote>
        // 分页(上拉加载)
        // request.fetchOffset = 0
        // request.fetchLimit = 20
        
        // 筛选
        // request.predicate = NSPredicate(format: "title = %@", "iOS")
        
        // 排序
        // let sortDescriptor1 = NSSortDescriptor(key: "updatedAt", ascending: true) // 根据 updatedAt 正向排序
        // let sortDescriptor2 = NSSortDescriptor(key: "title", ascending: true) // 再根据 title 正向排序
        // request.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        let sortDescriptor1 = NSSortDescriptor(key: "updatedAt", ascending: false) 
        request.sortDescriptors = [sortDescriptor1]
        
        request.returnsObjectsAsFaults = true
        request.propertiesToFetch = ["coverPhoto", "title", "updatedAt", "isVideo"]
        
        DispatchQueue.main.async {
            self.showLoadHUD()
        }
        
        backgroundContext.perform {
            if let draftNotes = try? backgroundContext.fetch(request) {
                self.draftNotes = draftNotes
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
            DispatchQueue.main.async {
                self.hideLoadHUD()
            }
        }
    }
    
    func getNotes() {
        let query = LCQuery(className: kNoteTable)
        
        query.whereKey(kChannelCol, .equalTo(self.channel))
        query.whereKey(kAuthorCol, .included)
        query.whereKey(kUpdatedAtCol, .descending)
        query.limit = kNotesOffset
        
        query.find { result in
            if case let .success(objects: notes) = result {
                self.notes = notes
                self.collectionView.reloadData()
            }
        }
    }
    
    func getMyNote(_ user: LCUser) {
        let query = LCQuery(className: kNoteTable)
        
        query.whereKey(kAuthorCol, .equalTo(user))
        query.whereKey(kAuthorCol, .included)
        query.whereKey(kUpdatedAtCol, .descending)
        query.limit = kNotesOffset
        
        query.find { result in
            if case let .success(objects: notes) = result {
                self.notes = notes
                self.collectionView.reloadData()
            }
        }
    }
    
}
