//
//  ViewController.swift
//  ScrollView-Code
//
//  Created by 惠蒲葵 on 2025/8/4.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let imageView: UIImageView = UIImageView(image: UIImage(named: "p1"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self
        
        self.scrollView.addSubview(self.imageView)
        self.scrollView.contentSize = imageView.bounds.size
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scaleFactor = self.scrollView.frame.width / self.imageView.frame.width
        
        self.scrollView.minimumZoomScale = scaleFactor
        self.scrollView.maximumZoomScale = 1
        self.scrollView.zoomScale = scaleFactor
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if self.imageView.frame.height < self.scrollView.frame.height {
            let offsetY: CGFloat = (self.scrollView.frame.height - self.imageView.frame.height) / 2
            self.imageView.center = CGPoint(x: self.imageView.frame.width / 2, y: self.imageView.frame.height / 2 + offsetY)
        }
    }
}

