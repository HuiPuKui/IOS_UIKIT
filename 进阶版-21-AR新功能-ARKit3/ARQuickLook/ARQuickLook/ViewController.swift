//
//  ViewController.swift
//  ARQuickLook
//
//  Created by 刘军 on 2020/3/30.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit
import ARKit
import QuickLook

class ViewController: UIViewController, QLPreviewControllerDataSource {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true, completion: nil)
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = Bundle.main.url(forResource: "house", withExtension: "usdz")!
        return url as QLPreviewItem
    }
    
}
