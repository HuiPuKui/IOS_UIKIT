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
}
