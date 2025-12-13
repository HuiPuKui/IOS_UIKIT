//
//  WaterfallVC-config.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/9.
//

import Foundation
import CHTCollectionViewWaterfallLayout

extension WaterfallVC {
    
    func config() {
        let layout = self.collectionView.collectionViewLayout as! CHTCollectionViewWaterfallLayout
        
        // 设置列数、Cell之间的行列间距、Collection的上下左右间距、布局方式
        layout.columnCount = 2
        layout.minimumColumnSpacing = kWaterfallPadding
        layout.minimumInteritemSpacing = kWaterfallPadding
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: kWaterfallPadding,
            bottom: kWaterfallPadding,
            right: kWaterfallPadding
        )
        layout.itemRenderDirection = .shortestFirst
        
//        if isMyDraft {
//            layout.sectionInset = UIEdgeInsets(
//                top: 44,
//                left: kWaterfallPadding,
//                bottom: kWaterfallPadding,
//                right: kWaterfallPadding
//            )
//        }
    }
    
}
