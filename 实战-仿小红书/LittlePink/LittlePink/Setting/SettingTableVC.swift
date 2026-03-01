//
//  SettingTableVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/1.
//

import UIKit
import Kingfisher
import LeanCloud

class SettingTableVC: UITableViewController {
    
    var user: LCUser!

    @IBOutlet weak var cacheSizeLabel: UILabel!
    
    var cacheSizeStr = kNoCachePH {
        didSet {
            DispatchQueue.main.async {
                self.cacheSizeLabel.text = self.cacheSizeStr
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ImageCache.default.calculateDiskStorageSize { res in
            if case let .success(size) = res {
                var cacheSizeStr: String {
                    guard size > 0 else { return kNoCachePH }
                    guard size >= 1024 else { return "\(size) B" }
                    guard size >= 1048576 else { return "\(size / 1024) KB" }
                    guard size >= 1073741824 else { return "\(size / 1048576) MB" }
                    return "\(size / 1073741824) GB"
                }
                
                self.cacheSizeStr = cacheSizeStr
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let accountTableVC = segue.destination as? AccountTableVC {
            accountTableVC.user = self.user
        }
    }

}
