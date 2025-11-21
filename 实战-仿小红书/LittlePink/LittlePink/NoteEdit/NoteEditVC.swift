//
//  NoteEditVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/17.
//

import UIKit
import AVKit
import YPImagePicker
import SKPhotoBrowser

class NoteEditVC: UIViewController {

    var photos: [UIImage] = []
    
    var videoURL: URL?
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photoCount: Int { return photos.count }
    
    var isVideo: Bool { self.videoURL != nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension NoteEditVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        
        cell.imageView.image = self.photos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            photoFooter.addPhotoBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            return photoFooter
        default:
            fatalError("collectionView的footer出问题了")
        }
    }
    
}

extension NoteEditVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isVideo {
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: self.videoURL!)
            
            self.present(playerVC, animated: true) {
                playerVC.player?.play()
            }
        } else {
            var images: [SKPhoto] = []
            
            for photo in self.photos {
                images.append(SKPhoto.photoWithImage(photo))
            }

            let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
            browser.delegate = self
            
            SKPhotoBrowserOptions.displayAction = false
            SKPhotoBrowserOptions.displayDeleteButton = true
            
            self.present(browser, animated: true, completion: {})
        }
    }
    
}

// MARK: - SKPhotoBrowserDelegate

extension NoteEditVC: SKPhotoBrowserDelegate {
    
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        self.photos.remove(at: index)
        
        self.photoCollectionView.reloadData()
        reload()
    }
    
}

// MARK: - 监听

extension NoteEditVC {
    
    @objc private func addPhoto(sender: UIButton) {
        if self.photoCount < kMaxPhotoCount {
            var config = YPImagePickerConfiguration()
            
            // MARK: 通用配置
            config.albumName = Bundle.main.appName
            config.screens = [.library]
            
            // MARK: 相册配置
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount - self.photoCount
            config.library.spacingBetweenItems = kSpacingBetweenPhotos
            
            // MARK: Gallery(多选完后的展示和编辑页面)-画廊
            config.gallery.hidesRemoveButton = false
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, _ in
                
                for item in items {
                    if case let .photo(p: photo) = item {
                        self.photos.append(photo.image)
                    }
                }
                
                self.photoCollectionView.reloadData()
        
                picker.dismiss(animated: true)
            }
            
            self.present(picker, animated: true)
        } else {
            self.showTextHUD("最多只能选择\(kMaxPhotoCount)张照片哦")
        }
    }
    
}
