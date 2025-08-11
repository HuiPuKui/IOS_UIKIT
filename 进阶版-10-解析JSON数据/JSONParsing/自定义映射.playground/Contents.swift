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
    "lessonCount": 199
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
    }
}

do {
    let course: Course = try JSONDecoder().decode(Course.self, from: courseJSONData)
    print(course)
} catch {
    print(error)
}
