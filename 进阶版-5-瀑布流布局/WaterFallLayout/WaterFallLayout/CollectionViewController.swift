//
//  CollectionViewController.swift
//  WaterFallLayout
//
//  Created by 惠蒲葵 on 2025/7/6.
//

import UIKit

private let reuseIdentifier = "Cell"
private let collectionViewContentInset = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)

class CollectionViewController: UICollectionViewController {

    var itemWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.contentInset = collectionViewContentInset
        
//        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.minimumInteritemSpacing = collectionViewContentInset.left
//        layout.minimumLineSpacing = collectionViewContentInset.left
//        
//        let itemWidth = (collectionView.bounds.width - collectionViewContentInset.left * (2 + 1)) / 2
//        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        let layout = self.collectionView.collectionViewLayout as! LebusWaterfallLayout
        
        self.itemWidth = (self.collectionView.bounds.width - collectionViewContentInset.left - collectionViewContentInset.right - layout.columnSpacing * CGFloat(layout.columnCount - 1)) / CGFloat(layout.columnCount)
        layout.columnCount = 3
        layout.delegate = self
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 16
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: "\(indexPath.row + 1)")
    
        // Configure the cell
    
        return cell
    }

}

extension CollectionViewController: LebusWaterfallLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        let imageSize: CGSize = UIImage(named: "\(indexPath.item + 1)")!.size
        let imageWidth: Double = imageSize.width
        let imageHeight: Double = imageSize.height
        let imageRatio: Double = imageHeight / imageWidth
        return itemWidth * imageRatio + 36
    }
    
}
