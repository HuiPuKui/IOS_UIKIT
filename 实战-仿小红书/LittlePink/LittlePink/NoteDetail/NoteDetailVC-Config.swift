//
//  NoteDetailVC-Config.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/3.
//

import Foundation
import ImageSlideshow

extension NoteDetailVC {
    
    func config() {
        self.imageSlideshow.zoomEnabled = true
        self.imageSlideshow.circular = false
        self.imageSlideshow.contentScaleMode = .scaleAspectFill
        self.imageSlideshow.activityIndicator = DefaultActivityIndicator()
        
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = mainColor
        
        self.imageSlideshow.pageIndicator = pageControl
    }
    
}
