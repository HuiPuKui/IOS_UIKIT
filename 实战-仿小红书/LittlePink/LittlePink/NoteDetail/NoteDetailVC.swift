//
//  NoteDetailVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/3.
//

import UIKit
import ImageSlideshow

class NoteDetailVC: UIViewController {

    @IBOutlet weak var authorAvatarBtn: UIButton!
    @IBOutlet weak var authorNickNameBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var imageSlideShowHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        
        self.imageSlideshow.setImageInputs([
            ImageSource(image: UIImage(named: "1")!),
            ImageSource(image: UIImage(named: "2")!),
            ImageSource(image: UIImage(named: "3")!)
        ])
        
        let imageSize = UIImage(named: "1")!.size
        self.imageSlideShowHeight.constant = (imageSize.height / imageSize.width) * screenRect.width
        
        self.setUI()
    }
    
    override func viewDidLayoutSubviews() {
        let height = self.tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = self.tableHeaderView.frame
        
        if frame.height != height {
            frame.size.height = height
            self.tableHeaderView.frame = frame
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
