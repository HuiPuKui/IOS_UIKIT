//
//  ViewController.swift
//  JSONParsing
//
//  Created by 惠蒲葵 on 2025/8/10.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    // lazy: 只有使用到这个 UI 控件的时候才会调用这个代码
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        
        // 设置属性
        tableView.translatesAutoresizingMaskIntoConstraints = false // 用约束来指定布局
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        self.view.addSubview(self.tableView)
        setUI()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        // 配置数据
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = courses[indexPath.row].title
        
        cell.contentConfiguration = contentConfig
        
        return cell
    }

}

extension ViewController {
    
    func loadData() {
        if let coursesJSONURL: URL = Bundle.main.url(forResource: "courses", withExtension: ".json") {
            if let coursesJSONData: Data = try? Data(contentsOf: coursesJSONURL) {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    self.courses = try decoder.decode([Course].self, from: coursesJSONData)
                    print(self.courses)
                } catch {
                    print("解析 json 数据失败，原因: \(error)")
                }
            } else {
                print("url 转 Data 失败")
            }
        } else {
            print("从 courses.json 文件中取 url 失败，检查拼写等")
        }
    }
    
}

extension ViewController {
    
    func setUI() {
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true // 如果要针对 safe area
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        // 等价于
        /*
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
         */
    }
    
}
