//
//  TodosTableVC-DataSource.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/6/1.
//

import UIKit

extension TodosTableVC {
    
    // MARK: - Table view data source

    // 代表这个 table view 有几段
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // 代表在每段里面有多少行
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.todos.count
    }

    // 当前这一行显示的内容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTodoCellID, for: indexPath) as! TodoCell
        let checkBoxBtn: UIButton = cell.checkBoxBtn!
        let todoLabel: UILabel = cell.todoLabel!
        let initSelected: Bool = self.todos[indexPath.row].checked
        
//        // 系统自带布局（虽然 storyboard 里面没有响应的 UI 控件，但仍旧可以这样使用）
//        var contentConfiguration: UIListContentConfiguration = cell.defaultContentConfiguration()
//        contentConfiguration.text = "昵称"
//        contentConfiguration.secondaryText = "个性签名"
//        contentConfiguration.image = UIImage(systemName: "star")
//        cell.contentConfiguration = contentConfiguration
        
        
        checkBoxBtn.isSelected = initSelected
        // 设置按钮的点击事件
//        if !self.isEditing {
//            checkBoxBtn.addAction(UIAction(handler: { action in
//                self.todos[indexPath.row].checked.toggle()
//                let checked: Bool = self.todos[indexPath.row].checked
//                checkBoxBtn.isSelected = checked
//                todoLabel.textColor = checked ? UIColor.tertiaryLabel : UIColor.label
//            }), for: UIControl.Event.touchUpInside)
//        }
        
        checkBoxBtn.tag = indexPath.row
        checkBoxBtn.addTarget(self, action: #selector(toggleCheck), for: UIControl.Event.touchUpInside)
        
        todoLabel.text = self.todos[indexPath.row].name
        todoLabel.textColor = initSelected ? UIColor.tertiaryLabel : UIColor.label
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { // 左滑删除
            context.delete(todos[indexPath.row])
            self.todos.remove(at: indexPath.row)
            appDelegate.saveContext()
//            self.saveData()
            // 根据最新数据更新视图
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let todoToRemove: Todo = self.todos[fromIndexPath.row]
        self.todos.remove(at: fromIndexPath.row)
        self.todos.insert(todoToRemove, at: to.row)
//        self.saveData()
        // 系统自动更新视图（存粹更新，不会调用 Data Source）
        self.tableView.reloadData()
    }
    
}

// 

// 监听函数
extension TodosTableVC {
    
    @objc func toggleCheck(checkBoxBtn: UIButton) -> Void {
        let row: Int = checkBoxBtn.tag
        self.todos[row].checked.toggle()
        appDelegate.saveContext()
//        self.saveData()
        
        let checked: Bool = self.todos[row].checked
        checkBoxBtn.isSelected = checked
        
        let cell: TodoCell = self.tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! TodoCell
        cell.todoLabel.textColor = checked ? UIColor.tertiaryLabel : UIColor.label
    }
    
}
