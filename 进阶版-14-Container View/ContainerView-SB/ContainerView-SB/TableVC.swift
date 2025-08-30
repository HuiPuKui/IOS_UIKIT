//
//  TableVC.swift
//  ContainerView-SB
//
//  Created by 惠蒲葵 on 2025/8/30.
//

import UIKit

class TableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("tableVC 子视图控制器")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "我是一条评论"
        return cell
    }

}
