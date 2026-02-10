//
//  NoteDetailVC-Config.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/3.
//

import Foundation
import ImageSlideshow
import GrowingTextView
import LeanCloud

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
        
        if LCApplication.default.currentUser == nil {
            self.likeBtn.setToNormal()
            self.favBtn.setToNormal()
        }
        
        // textView
        self.textView.textContainerInset = UIEdgeInsets(top: 11.5, left: 16, bottom: 11.5, right: 16)
        self.textView.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        
        self.tableView.register(
            UINib(nibName: "CommentView", bundle: nil),
            forHeaderFooterViewReuseIdentifier: kCommentViewID
        )
        
        self.tableView.register(
            CommentSectionFooterView.self,
            forHeaderFooterViewReuseIdentifier: kCommentSectionFooterViewID
        )
        
        if #available(iOS 15.0, *) {
            // 解决 tableHeaderView 和第一个 section header 之间的白条问题
            self.tableView.sectionHeaderTopPadding = 0
        }
    }
    
    func adjustTableHeaderViewHeight() {
        let height = self.tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = self.tableHeaderView.frame
        
        if frame.height != height {
            frame.size.height = height
            self.tableHeaderView.frame = frame
        }
    }
    
}

extension NoteDetailVC: GrowingTextViewDelegate {
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension NoteDetailVC {
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardH = screenRect.height - endFrame.origin.y

            if keyboardH > 0 {
                self.view.insertSubview(self.overlayView, belowSubview: self.textViewBarView)
            } else {
                self.overlayView.removeFromSuperview()
                self.textViewBarView.isHidden = true
            }
            
            self.textViewBarBottomConstraint.constant = keyboardH
            
            self.view.layoutIfNeeded()
        }
    }
    
}
