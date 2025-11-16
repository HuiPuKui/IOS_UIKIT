import UIKit

// ARC(Automatic Reference Counting)-自动引用计数
// 内存管理机制

// Reference Cycle-循环引用
// 解决方法: weak(弱引用) 和 unowned(无主引用)
class Video {
    unowned var author: Author // unowned 解决循环引用
    
    init(author: Author) {
        self.author = author
    }
    
    deinit {
        print("video 对象被销毁了")
    }
}

class Author {
    var name: String
    weak var video: Video? // weak 解决循环引用
    
    init(name: String, video: Video? = nil) {
        self.name = name
        self.video = video
    }
    
    deinit {
        print("author 对象被销毁了")
    }
}

var author: Author? = Author(name: "Lebus")
var video: Video? = Video(author: author!)
author?.video = video

// 若不添加 weak/unowned 无法释放，最终循环引用
author = nil
video = nil


// MARK: - delegate 等属性被标记为 weak 的原因，也需放置滥用

class vc: UIViewController, UITableViewDelegate {
    var tableView: UITableView!
    override func viewDidLoad() {
        self.tableView.delegate = self
    }
}


// MARK: - 捕获列表 CaptureList -- 闭包循环引用的解决方案
// 1. 普通闭包

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String?) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil

// 2. 逃逸闭包 -- 见 didFinishPicking
