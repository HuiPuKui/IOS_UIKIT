import UIKit

// ARC(Automatic Reference Counting)-自动引用计数
// 内存管理机制

// Reference Cycle-循环引用

class Video {
    var author: Author
    
    init(author: Author) {
        self.author = author
    }
    
    deinit {
        print("video 对象被销毁了")
    }
}

class Author {
    var name: String
    var video: Video?
    
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

// 无法释放，最终循环引用
author = nil
video = nil


