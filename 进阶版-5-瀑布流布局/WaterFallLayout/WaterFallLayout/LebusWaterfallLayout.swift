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
    
    // 所有 cell 的布局属性
    private var layoutAttributesArr: [UICollectionViewLayoutAttributes] = []
    
    // 首次布局和更新布局的时候调用
    override func prepare() {
        super.prepare()
        
        guard
            let collectionView = self.collectionView,
            self.layoutAttributesArr.isEmpty
        else { return }
        
        let itemWidth: CGFloat = (self.collectionViewContentWidth - self.columnSpacing) / 2
        
        var x: [CGFloat] = []
        for column in 0..<self.columnCount {
            x.append((itemWidth + self.columnSpacing) * CGFloat(column))
        }
        
        var y: [CGFloat] = Array(repeating: 0, count: columnCount)
        
        
        var column = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath: IndexPath = IndexPath(item: item, section: 0)
            let itemHeight: CGFloat = delegate?.collectionView(collectionView, heightForItemAt: indexPath) ?? 100
            let itemFrame: CGRect = CGRect(x: x[column], y: y[column], width: itemWidth, height: itemHeight)
            
            let layoutAttributes: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            layoutAttributes.frame = itemFrame
            self.layoutAttributesArr.append(layoutAttributes)
            
            self.collectionViewContentHeight = max(collectionViewContentHeight, itemFrame.maxY)
            
            y[column] = y[column] + itemHeight + lineSpacing
            column = y.firstIndex(of: y.min()!)!
        }
    }
    
    // 返回某一矩形区域内的所有 item（或 header/footer）的布局信息
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributesArr: [UICollectionViewLayoutAttributes] = []
        for layoutAttributes in self.layoutAttributesArr {
            // 判断是否与可见区域相交
            if layoutAttributes.frame.intersects(rect) {
                visibleLayoutAttributesArr.append(layoutAttributes)
            }
        }
        return visibleLayoutAttributesArr
    }
    
    // 返回指定 indexPath 的 item 的布局信息
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutAttributesArr[indexPath.item]
    }
}
