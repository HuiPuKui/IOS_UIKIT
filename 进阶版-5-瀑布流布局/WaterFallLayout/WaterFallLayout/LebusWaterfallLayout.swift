//
//  LebusWaterfallLayout.swift
//  WaterFallLayout
//
//  Created by 惠蒲葵 on 2025/7/10.
//

import UIKit

// 只能被引用类型继承 - AnyObject
protocol LebusWaterfallLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat
}

class LebusWaterfallLayout: UICollectionViewLayout {
    let columnCount: Int = 2
    let columnSpacing: CGFloat = 4
    let lineSpacing: CGFloat = 4
    
    weak var delegate: LebusWaterfallLayoutDelegate?
    
    var collectionViewContentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
    }
    
    var collectionViewContentHeight: CGFloat = 0
    
    // 子类必须重写这个属性，为了确定瀑布流布局内容的大小
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionViewContentWidth, height: self.collectionViewContentHeight)
    }
    
    // 首次布局和更新布局的时候调用
    override func prepare() {
        super.prepare()
    }
    
//    // 返回某一矩形区域内的所有 item（或 header/footer）的布局信息
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        
//    }
//    
//    // 返回指定 indexPath 的 item 的布局信息
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        
//    }
}
