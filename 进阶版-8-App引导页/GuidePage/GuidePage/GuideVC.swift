//
//  GuideVC.swift
//  GuidePage
//
//  Created by 惠蒲葵 on 2025/8/4.
//

import UIKit

class GuideVC: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension GuideVC: UIScrollViewDelegate {
    
    // 每一帧都会调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let viewWidth = self.view.bounds.width
        
        let pageIndex: CGFloat = round(x / viewWidth)
        self.pageControl.currentPage = Int(pageIndex)
        
        if x > (viewWidth * 2 + 50) {
            // 找到箭头指向的初始页面
            let homeVC = self.storyboard?.instantiateInitialViewController()!
            // 全屏展示
            homeVC?.modalPresentationStyle = .fullScreen
            present(homeVC!, animated: true)
        }
    }
    
}
