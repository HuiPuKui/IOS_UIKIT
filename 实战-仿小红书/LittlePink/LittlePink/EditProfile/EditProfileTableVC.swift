//
//  EditProfileTableVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/25.
//

import UIKit

class EditProfileTableVC: UITableViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    var avatar: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.avatarImageView.image = self.avatar
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 手写自定义软键盘
//        self.textField.inputView = self.genderPickerView
//        self.tableView.addSubview(self.textField)
    }

    @IBAction func back(_ sender: Any) {
        
    }
    
//    lazy var textField: UITextField = {
//        let textField = UITextField(frame: .zero)
//        return textField
//    }()
//    
//    lazy var genderPickerView: UIStackView = {
//        let cancelBtn = UIButton()
//        self.setToolBarBtn(cancelBtn, title: "取消", color: .secondaryLabel)
//        let doneBtn = UIButton()
//        self.setToolBarBtn(doneBtn, title: "完成", color: mainColor)
//        
//        let toolBarView = UIStackView(arrangedSubviews: [cancelBtn, doneBtn])
//        toolBarView.distribution = .equalSpacing
//        
//        let pickerView = UIPickerView()
//        pickerView.dataSource = self
//        pickerView.delegate = self
//        
//        let genderPickerView = UIStackView(arrangedSubviews: [toolBarView, pickerView])
//        genderPickerView.frame.size.height = 150
//        genderPickerView.axis = .vertical
//        genderPickerView.spacing = 8
//        genderPickerView.backgroundColor = .secondarySystemBackground
//        
//        return genderPickerView
//    }()
//    
//    private func setToolBarBtn(_ btn: UIButton, title: String, color: UIColor) {
//        btn.setTitle(title, for: .normal)
//        btn.titleLabel?.font = .systemFont(ofSize: 14)
//        btn.setTitleColor(color, for: .normal)
//        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
//    }
    
}

//extension EditProfileTableVC: UIPickerViewDataSource, UIPickerViewDelegate {
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 2
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return ["男", "女"][row]
//    }
//    
//}
