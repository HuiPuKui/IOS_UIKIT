//
//  TodosTableVC-Delegate.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/6/1.
//

import UIKit

extension TodosTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消选择（做出点击后，灰色底色闪一下的效果）
        self.tableView.deselectRow(at: indexPath, animated: true)
//        let vc: TodoTableVC = self.storyboard?.instantiateViewController(withIdentifier: kTodoTableVCID) as! TodoTableVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 左滑删除的文本
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "点击以删除"
    }
    
    // 自定义编辑样式
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return self.isEditing ? UITableViewCell.EditingStyle.none : UITableViewCell.EditingStyle.delete
    }
    
    // 编辑模式下是否需要缩进
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension TodosTableVC: TodoTableVCDelegate {
    
    func didAdd(name: String) {
        self.todos.append(Todo(name: name, checked: false))
        
        // 其实是把表格重新刷新了一下（只添加的部分）
        self.tableView.insertRows(at: [IndexPath(row: self.todos.count - 1, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    func didEdit(name: String) {
        self.todos[self.row].name = name
        
//        let indexPath: IndexPath = IndexPath(row: self.row, section: 0)
//        let cell: TodoCell = self.tableView.cellForRow(at: indexPath) as! TodoCell
//        cell.todoLabel.text = self.todos[self.row].name
        
        // 更方便：直接刷新
        self.tableView.reloadData()
    }
    
}
