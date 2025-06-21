//
//  ViewController.swift
//  DoubleTableView
//
//  Created by 惠蒲葵 on 2025/6/15.
//

import UIKit

let kCategoryCellID: String = "CategoryCellID"
let kMenuCellID: String = "MenuCellID"
let kCategoryHeaderNibName = "CategoryHeader"
let kCategoryHeaderID = "CategoryHeaderID"

class ViewController: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var menuTableView: UITableView!
    
    var categories: [String] = []
    var menus: [[Menu]] = []
    
    var menuTableViewGoDown: Bool = true
    
    var menuTableViewCurrentContentOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuTableView.register(UINib(nibName: kCategoryHeaderNibName, bundle: nil), forHeaderFooterViewReuseIdentifier: kCategoryHeaderID)
        
        for i in 1...20 {
            categories.append("分类\(i)")
        }
        
        for category in categories {
            var menusPerCategory: [Menu] = []
            for i in 1...3 {
                let menu: Menu = Menu(menuImageName: "food", menuName: "\(category) - 外卖菜品\(i)", price: Double(i))
                menusPerCategory.append(menu)
            }
            menus.append(menusPerCategory)
        }
        
        self.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.none)
    }

}


extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView == self.categoryTableView ? 1 : self.categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.categoryTableView ? categories.count : menus[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.categoryTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCategoryCellID, for: indexPath) as! CategoryCell
            cell.categoryLabel.text = self.categories[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kMenuCellID, for: indexPath) as! MenuCell
            cell.menu = self.menus[indexPath.section][indexPath.row]
            return cell
        }
    }
    
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.categoryTableView {
            return nil
        }
        
        let categoryHeader: CategoryHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCategoryHeaderID) as! CategoryHeader
        categoryHeader.categoryNameLabel.text = self.categories[section]
        return categoryHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView == self.categoryTableView ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.categoryTableView {
            self.menuTableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: UITableView.ScrollPosition.top, animated: true)
            self.categoryTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
        }
    }
    
    // 判断向上还是向下
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView: UITableView = scrollView as! UITableView
        if tableView == self.menuTableView {
            self.menuTableViewGoDown = self.menuTableViewCurrentContentOffsetY < tableView.contentOffset.y
            self.menuTableViewCurrentContentOffsetY = tableView.contentOffset.y
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // 是菜单 并且 向下 并且 拖拽或惯性减速
        if tableView == self.menuTableView && !self.menuTableViewGoDown && (self.menuTableView.isDragging || self.menuTableView.isDecelerating) {
            self.categoryTableView.selectRow(at: IndexPath(row: section, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.top)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        // 是菜单 并且 向上 并且 拖拽或惯性减速
        if tableView == self.menuTableView && self.menuTableViewGoDown && (self.menuTableView.isDragging || self.menuTableView.isDecelerating) {
            self.categoryTableView.selectRow(at: IndexPath(row: section + 1, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.top)
        }
    }
    
}
