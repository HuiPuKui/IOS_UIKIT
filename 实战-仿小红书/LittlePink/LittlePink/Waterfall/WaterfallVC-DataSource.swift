//
//  WaterfallVC-DataSource.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/11.
//

import Foundation

extension WaterfallVC {
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if self.hasDraft {
            return self.notes.count + 1
        } else if self.isMyDraft {
            return self.draftNotes.count
        } else {
            return self.notes.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.hasDraft, indexPath.item == 0 {
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: kMyDraftNoteWaterfallCellID, for: indexPath)
            return cell
        } else if self.isMyDraft {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: kDraftNoteWaterfallCellID,
                for: indexPath
            ) as! DraftNoteWaterfallCell
            cell.draftNote = self.draftNotes[indexPath.item]
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: kWaterfallCellID,
                for: indexPath
            ) as! WaterfallCell
            let offset = self.hasDraft ? 1 : 0
            cell.note = self.notes[indexPath.item - offset]
            return cell
        }
    }

}

// MARK: - 一般函数

extension WaterfallVC {
    
    private func deleteDraftNote(_ index: Int) {
        
        backgroundContext.perform {
            let draftNote = self.draftNotes[index]
            
            // 数据
            backgroundContext.delete(draftNote)
            appDelegate.saveBackgroundContext()
            
            self.draftNotes.remove(at: index)
            
            UserDefaults.decrease(kDraftNoteCount)
            
            // UI
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.showTextHUD("删除草稿成功")
            }
        }
        
    }
    
}

// MARK: - 监听

extension WaterfallVC {
    
    @objc private func showAlert(_ sender: UIButton) {
        let index = sender.tag
        
        let alert = UIAlertController(title: "提示", message: "确认删除该草稿吗?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "取消", style: .cancel)
        let action2 = UIAlertAction(title: "确认", style: .destructive) { _ in
            self.deleteDraftNote(index)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true)
    }
    
}
