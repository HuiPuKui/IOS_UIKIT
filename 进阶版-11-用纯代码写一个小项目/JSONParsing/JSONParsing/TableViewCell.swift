//
//  TableViewCell.swift
//  JSONParsing
//
//  Created by 惠蒲葵 on 2025/8/16.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // lazy 的变量必须定义为 var
    private lazy var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 22)
        titleLabel.text = "iOS开发-基础版"
        return titleLabel
    }()
    
    private lazy var serviceBtn: UIButton = {
        let serviceBtn: UIButton = UIButton()
        
        serviceBtn.setTitle("终生保价", for: .normal)
        serviceBtn.titleLabel?.font = .systemFont(ofSize: 15) // 字号
        serviceBtn.setTitleColor(UIColor(named: "btnTextColor"), for: .normal) // 标题颜色
        serviceBtn.backgroundColor = UIColor(named: "btnBgColor") // 背景颜色
        
        serviceBtn.layer.cornerRadius = 5 // 圆角
        serviceBtn.clipsToBounds = true // 修剪
        
        return serviceBtn
    }()
    
    private lazy var serviceBtnStackView: UIStackView = {
        let serviceBtnStackView: UIStackView = UIStackView(arrangedSubviews: [
            self.serviceBtn,
            self.serviceBtn
        ])
        
        serviceBtnStackView.axis = .horizontal // 横向
        serviceBtnStackView.distribution = .fillProportionally // 等比例拉伸
        serviceBtnStackView.spacing = 5 // 间隔
        
        return serviceBtnStackView
    }()
    
    private lazy var courseStackView: UIStackView = {
        let courseStackView: UIStackView = UIStackView(arrangedSubviews: [
            self.titleLabel,
            self.serviceBtnStackView,
            self.lessonCountLabel
        ])
        
        courseStackView.axis = .vertical // 纵向
        courseStackView.alignment = .leading // 靠左对齐
        courseStackView.spacing = 6 // 间隔
        courseStackView.translatesAutoresizingMaskIntoConstraints = false // 自己来定义布局约束
        
        return courseStackView
    }()
    
    private lazy var lessonCountLabel: UILabel = {
        let lessonCountLabel: UILabel = UILabel()
        lessonCountLabel.textColor = .secondaryLabel
        lessonCountLabel.font = .systemFont(ofSize: 15, weight: .medium)
        lessonCountLabel.text = "199课时"
        return lessonCountLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.courseStackView)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TableViewCell {
    
    func setUI() {
        self.courseStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        self.courseStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
        self.courseStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.courseStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
    }
    
}
