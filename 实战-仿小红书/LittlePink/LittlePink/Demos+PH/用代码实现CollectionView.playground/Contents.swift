//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    private lazy var cv: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    override func loadView() {
        let view = UIView()
        
        view.addSubview(cv)
        self.setUI()
        
        self.view = view
    }
    
    private func setUI() {
        cv.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        cv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        cv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        cv.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
