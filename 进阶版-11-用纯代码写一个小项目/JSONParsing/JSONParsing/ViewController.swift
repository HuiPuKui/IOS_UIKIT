//
//  ViewController.swift
//  JSONParsing
//
//  Created by 惠蒲葵 on 2025/8/10.
//

import UIKit

class ViewController: UIViewController {
    
    var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
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
