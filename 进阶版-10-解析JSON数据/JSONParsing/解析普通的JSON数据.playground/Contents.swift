import UIKit

// JavaScript 一种对象
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
    "lessonCount": 199
}
"""

let courseJSONData: Data = courseJSON.data(using: .utf8)!

// 原则上属性名要和 json 数据里的 key 一模一样（包括大小写），属性类型也要和 value 类型一样，不然会解码失败
// 注1: 不一定要列出 json 数据里的每一个属性
// 注2: json 数据中 1.key 可能有可能没有的，2.key 有但 value 可能是 nil 的，需要定义成可选型
struct Course: Codable {
    let id: Int
    let title: String
    let url: URL
    let level: String
    let technology: Technology
    let service: [String]?
    let lessonCount: Int
    
    struct Technology: Codable {
        let lan: String
        let editor: String
        let framework: String
    }
}

do {
    let course: Course = try JSONDecoder().decode(Course.self, from: courseJSONData)
    print(course.title)
} catch {
    print(error)
}
