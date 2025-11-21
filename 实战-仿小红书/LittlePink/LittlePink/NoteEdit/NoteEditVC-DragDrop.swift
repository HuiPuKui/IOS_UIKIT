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
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: any UICollectionViewDropCoordinator) {
        
    }
    
}
