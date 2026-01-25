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
        // imageSlideshow
        self.imageSlideshow.zoomEnabled = true
        self.imageSlideshow.circular = false
        self.imageSlideshow.contentScaleMode = .scaleAspectFill
        self.imageSlideshow.activityIndicator = DefaultActivityIndicator()
        
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = mainColor
        
        self.imageSlideshow.pageIndicator = pageControl
        
        // textView
        self.textView.textContainerInset = UIEdgeInsets(top: 11.5, left: 16, bottom: 11.5, right: 16)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
}

extension NoteDetailVC {
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardH = endFrame.height
            
            if keyboardH > 0 {
                
            } else {
                
            }
        }
    }
    
}
