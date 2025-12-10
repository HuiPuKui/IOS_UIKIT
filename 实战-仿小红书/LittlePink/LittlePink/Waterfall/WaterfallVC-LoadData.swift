//
//  WaterfallVC-LoadData.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/9.
//

import CoreData
import Foundation

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
        
        let draftNotes = try! context.fetch(request)
        self.draftNotes = draftNotes
    }
    
}
