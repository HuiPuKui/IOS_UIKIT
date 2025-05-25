//
//  TodoTableVC.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/5/25.
//

import UIKit

protocol TodoTableVCDelegate {
    
    func didAdd(name: String) -> Void
    
}

class TodoTableVC: UITableViewController {

    var delegate: TodoTableVCDelegate?
    
    @IBOutlet weak var todoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem?.image = pointItem("chevron.left.circle.fill")
        self.navigationItem.rightBarButtonItem?.image = pointItem("checkmark.circle.fill")
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(_ sender: Any) {
        
        if !self.todoTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            delegate?.didAdd(name: self.todoTextView.text)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
