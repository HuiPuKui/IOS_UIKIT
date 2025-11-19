//
//  ViewController.swift
//  UIKitTest
//
//  Created by 惠蒲葵 on 2025/11/19.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    private let photos = [UIImage(named: "1"), UIImage(named: "2")]
    
    private lazy var cv: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        
        cv.register(CVCell.self, forCellWithReuseIdentifier: "CVCellID")
        cv.dataSource = self
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cv)
        self.setUI()
    }
    
    private func setUI() {
        cv.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        cv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        cv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        cv.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCellID", for: indexPath) as! CVCell
        
        cell.imageView.image = self.photos[indexPath.item]
        
        return cell
    }

}

class CVCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.imageView)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
}
