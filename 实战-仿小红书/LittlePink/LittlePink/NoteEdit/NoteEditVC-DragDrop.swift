//
//  NoteEditVC-DragDrop.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/22.
//

import Foundation

// MARK: - UICollectionViewDragDelegate

extension NoteEditVC: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider(object: self.photos[indexPath.item]))]
    }
    
}

// MARK: - UICollectionViewDropDelegate

extension NoteEditVC: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: any UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        // DropProposal -- 放开 cell 的方案
        // 若需实现 section 间不可拖拽的功能: 可定全局变量 dragingIndexPath，在 itemsForBeginning 中赋值为 indexPath，然后对比 section 是否等于 destinationIndexpath 的 section，若等于则返回 forbidden。
        
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: any UICollectionViewDropCoordinator) {
        
    }
    
}
