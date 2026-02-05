//
//  NoteDetailVC-TVDataSource.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/27.
//

import Foundation

extension NoteDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReplyCellID, for: indexPath)
        
        return cell
    }

}
