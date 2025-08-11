import UIKit

// mapping

let courseJSON = """
{
    "id": 1,
    "title": "iOS开发-零基础版",
    "url": "https://www.cctalk.com/m/group/86306378",
    "level": "初级",
    "technology": {
        "lan": "Swift",
        "editor": "Xcode",
        "framework": "UIKit"
    },
    "service": ["终生保价", "永久更新"],
    "lesson_count": 199
}
"""

let courseJSONData: Data = courseJSON.data(using: .utf8)!

struct Course: Codable {
    let id: Int
    let title: String
    let webURL: URL
    let level: Level
    let technology: Technology
    let service: [String]?
    let lessonCount: Int
    
    // json 没有对应的属性(常量，默认值) - 方法一
    let createTime1: Date = Date()
    // json 没有对应的属性(变量，可选型) - 方法二
    var createTime2: Date?
    // json 没有对应的属性(CodingKeys 不写这个属性) - 方法三
    var createTime3: Date = Date()
    // json 没有对应的属性(计算属性) - 方法四
    var createTime4: Date {
        Date()
    }
    
    // 一定要原始值在前面，系统默认赋值的原始值和变量名一样
    enum Level: String, Codable {
        case 初级, 中级, 高级
    }
    
    struct Technology: Codable {
        let lan: String
        let editor: String
        let framework: String
    }
}

extension Course {
    // 映射名：解决名称不同或者名称为关键字等，一定要叫 CodingKeys
    enum CodingKeys: String, CodingKey {
        case id, title, level, technology, service, lessonCount
        case webURL = "url"
        
        // 下划线转小驼峰 - 方法一
        // case lessonCount = "lesson_count"
    }
}

do {
    // 下划线转小驼峰 - 方法二
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase // 下划线命名法
    
    let course: Course = try decoder.decode(Course.self, from: courseJSONData)
    print(course)
} catch {
    print(error)
}


struct Todo: Codable {
    var name: String
    var checked: Bool
}

let todos: [Todo] = [Todo(name: "xx", checked: false)]

let todosJSONData: Data = try! JSONEncoder().encode(todos)

let decodedTodos: [Todo] = try! JSONDecoder().decode([Todo].self, from: todosJSONData)

