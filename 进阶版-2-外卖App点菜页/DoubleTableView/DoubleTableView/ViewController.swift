//
//  ViewController.swift
//  DoubleTableView
//
//  Created by 惠蒲葵 on 2025/6/15.
//

import UIKit

let kCategoryCellID: String = "CategoryCellID"
let kMenuCellID: String = "MenuCellID"

class ViewController: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var menuTableView: UITableView!
    
    var categories: [String] = []
    var menus: [[Menu]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...20 {
            categories.append("分类\(i)")
        }
        
        for category in categories {
            var menusPerCategory: [Menu] = []
            for i in 1...3 {
                let menu: Menu = Menu(imageName: "food", menuName: "\(category) - 外卖菜品\(i)", price: Double(i))
                menusPerCategory.append(menu)
            }
            menus.append(menusPerCategory)
        }
    }


}

