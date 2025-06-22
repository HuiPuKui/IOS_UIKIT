//
//  ViewController.swift
//  AccessLevel
//
//  Created by 惠蒲葵 on 2025/6/23.
//

import UIKit

// class 前面也是默认 internal
class ViewController: UIViewController {

    private var name: String = "张三"
    fileprivate var name1: String = "张三"
    internal var name2: String = "张三"
    var age: Int = 18
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension ViewController {
    
    func testPrivate() -> Void {
        print(self.name)
    }
    
}

func testFilePrivate() -> Void {
    print(ViewController().name1)
}
