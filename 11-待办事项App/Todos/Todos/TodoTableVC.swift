//
//  TodoTableVC.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/5/25.
//

import UIKit

protocol TodoTableVCDelegate {
    
    func didAdd(name: String) -> Void
    
    func didEdit(name: String) -> Void
    
}

class TodoTableVC: UITableViewController {

    var delegate: TodoTableVCDelegate?
    
    var name: String?
    
    @IBOutlet weak var todoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 聚焦
        self.todoTextView.becomeFirstResponder()
        self.todoTextView.text = self.name
        
        if self.name != nil {
            self.navigationItem.title = "编辑待办事项"
        }
        
        self.navigationItem.leftBarButtonItem?.image = pointItem("chevron.left.circle.fill")
        self.navigationItem.rightBarButtonItem?.image = pointItem("checkmark.circle.fill")
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(_ sender: Any) {
        
        if !self.todoTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            let name: String = self.todoTextView.text!
            if self.name != nil {
                delegate?.didEdit(name: name)
            } else {
                delegate?.didAdd(name: name)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension TodoTableVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        // 让 tableview 重新布局（带动画），会根据 storyboard 上定的约束换行或减行
        // 老版本写法
//        self.tableView.beginUpdates()
//        self.tableView.endUpdates()
        
        // 新版本写法 批量更新
        self.tableView.performBatchUpdates {
            
        }
    }
    
}
