//
//  TodosTableVC.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/5/23.
//

import UIKit

// present / dismiss
// push / pop (压栈 / 出栈)

class TodosTableVC: UITableViewController {

    var todos: [Todo] = [
        Todo(name: "学习 Lebus 的《iOS基础版》课程", checked: false),
        Todo(name: "学习 Lebus 的《iOS进阶版》课程", checked: false),
        Todo(name: "学习 Lebus 的《iOS仿小红书实战项目》课程", checked: true),
        Todo(name: "学习 Lebus 的《iOS推送》课程", checked: false),
        Todo(name: "学习 Lebus 的《iOS-SwiftUI》课程", checked: false)
    ]
    
    // 等价写法
    // var todos = [Todo]()
    
    var row: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.editButtonItem.title = nil
        self.editButtonItem.image = pointItem("arrow.up.arrow.down.circle.fill")
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.navigationItem.rightBarButtonItem?.image = pointItem("plus.circle.fill")
        
        if let data: Data = UserDefaults.standard.data(forKey: kTodosKey) {
            if let todos = try? JSONDecoder().decode([Todo].self, from: data) {
                self.todos = todos
            } else {
                print("解码失败")
            }
        }
    }
    
    // 点击编辑按钮触发的方法
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        // 二者只能存在一个
        if self.isEditing {
            self.editButtonItem.image = nil
            self.editButtonItem.title = "完成"
        } else {
            self.editButtonItem.title = nil
            self.editButtonItem.image = pointItem("arrow.up.arrow.down.circle.fill")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc: TodoTableVC = segue.destination as! TodoTableVC
        vc.delegate = self
        
        if segue.identifier == kEditTodoID {
            let cell: TodoCell = sender as! TodoCell
            vc.delegate = self
            // cell -> indexPath
            self.row = self.tableView.indexPath(for: cell)!.row
//            // indexPath -> cell
//            self.tableView.cellForRow(at: IndexPath) as! TodoCell
            vc.name = self.todos[self.row].name
        }
    }
    
}


