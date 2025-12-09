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
        let draftNotes = try! context.fetch(DraftNote.fetchRequest() as NSFetchRequest<DraftNote>)
        self.draftNotes = draftNotes
    }
    
}
