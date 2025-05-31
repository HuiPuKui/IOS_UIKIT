//
//  TodosTableVC-Delegate.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/6/1.
//

import UIKit

extension TodosTableVC {
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消选择（做出点击后，灰色底色闪一下的效果）
        self.tableView.deselectRow(at: indexPath, animated: true)
//        let vc: TodoTableVC = self.storyboard?.instantiateViewController(withIdentifier: kTodoTableVCID) as! TodoTableVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
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
