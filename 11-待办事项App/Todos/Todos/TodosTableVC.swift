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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationItem.rightBarButtonItem?.image = pointItem("plus.circle.fill")
    }

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
        checkBoxBtn.addAction(UIAction(handler: { action in
            self.todos[indexPath.row].checked.toggle()
            let checked: Bool = self.todos[indexPath.row].checked
            checkBoxBtn.isSelected = checked
            todoLabel.textColor = checked ? UIColor.tertiaryLabel : UIColor.label
        }), for: UIControl.Event.touchUpInside)
        
        todoLabel.text = self.todos[indexPath.row].name
        todoLabel.textColor = initSelected ? UIColor.tertiaryLabel : UIColor.label
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc: TodoTableVC = segue.destination as! TodoTableVC
        if segue.identifier == kAddTodoID {
            vc.delegate = self
        } else if segue.identifier == kEditTodoID {
            let cell: TodoCell = sender as! TodoCell
            // cell -> indexPath
            let row: Int = self.tableView.indexPath(for: cell)!.row
//            // indexPath -> cell
//            self.tableView.cellForRow(at: IndexPath) as! TodoCell
            vc.name = self.todos[row].name
        }
    }
    
}

extension TodosTableVC: TodoTableVCDelegate {
    
    func didAdd(name: String) {
        self.todos.append(Todo(name: name, checked: false))
        
        // 其实是把表格重新刷新了一下（只添加的部分）
        self.tableView.insertRows(at: [IndexPath(row: self.todos.count - 1, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
}
