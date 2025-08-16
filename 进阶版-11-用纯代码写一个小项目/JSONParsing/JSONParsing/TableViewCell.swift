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
        return titleLabel
    }()
    
    /*
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
     */
    
    private lazy var serviceBtnStackView: UIStackView = {
        // 重复添加多个 serviceBtn，只会覆盖掉前面的，因 serviceBtn 是同一个视图（同一个内存地址）
        // 具体原因参考 addSubview 文档：一个 view 只能有一个父视图，比如当前这个 view 已经被添加进某个父视图中了，之后再想把这个 view 添加到别的（也可以是之前那个，如下）父视图中的话，那系统会先把这个 view 从之前的父视图中移除，然后添加到新的父视图中
        // 这里的 serviceBtn 数组，第一个 btn 元素被添加进 serviceBtnStackView，然后第二个 btn 元素的时候，又把这个 btn 添加进同样的父视图 stackView 中了，此时系统也会把 btn 从父视图中移除，然后再把 btn 添加进 stackView。（相当于原来盒子中有一个东西，我先拿出来，之后又放回去了）
        // 也就是说，不断的添加同一个子视图，最终只会添加一个子视图
//        let serviceBtnStackView: UIStackView = UIStackView(arrangedSubviews: [
//            self.serviceBtn,
//            self.serviceBtn
//        ])
        
        let serviceBtnStackView: UIStackView = UIStackView(arrangedSubviews: [])
        
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
    
    var course: Course? {
        didSet {
            guard let course = self.course else { return }
            
            self.titleLabel.text = course.title
            
            for service in course.services {
                let btn = UIButton()
                var config = UIButton.Configuration.tinted()
                var attrTitle: AttributedString = AttributedString(service)
                
                attrTitle.font = .systemFont(ofSize: 15) // 字号
                attrTitle.foregroundColor = UIColor(named: "btnTextColor") // 标题颜色
                
                config.attributedTitle = attrTitle
                config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 5, bottom: 4, trailing: 5)
                config.background.backgroundColor = UIColor(named: "btnBgColor") // 背景颜色
                
                btn.configuration = config

                self.serviceBtnStackView.addArrangedSubview(btn)
            }
            
            self.lessonCountLabel.text = "\(course.lessonCount)课时"
        }
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
