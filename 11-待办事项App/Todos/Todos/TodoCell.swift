//
//  TodoCell.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/5/25.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var checkBoxBtn: UIButton!
    
    @IBOutlet weak var todoLabel: UILabel!
    
    // awakeFromNib 和 cellForItemAt 的执行顺序:
    // dequeueReusableCell -> awakeFromNib -> dequeueReusableCell 后面的内容
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置未选中与选中的按钮图片
        self.checkBoxBtn.setImage(UIImage(systemName: "circle"), for: UIControl.State.normal)
        self.checkBoxBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: UIControl.State.selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
