import UIKit

// 现实开发中用的最多的，json 数组最外层是数组的情况
let coursesJSON = """
[
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
    },
    {
        "id": 2,
        "title": "iOS开发-进阶版",
        "url": "https://www.cctalk.com/m/group/86308246",
        "level": "中级",
        "technology": {
            "lan": "Swift",
            "editor": "Xcode",
            "framework": "UIKit"
        },
        "service": ["终生保价", "永久更新"],
        "lessonCount": 220
    },
    {
        "id": 3,
        "title": "iOS开发-SwiftUI",
        "url": "https://www.cctalk.com/m/group/86559266",
        "level": "中级",
        "technology": {
            "lan": "Swift",
            "editor": "Xcode",
            "framework": "SwiftUI"
        },
        "service": ["终生保价", "永久更新"],
        "lessonCount": 155
    },
    {
        "id": 4,
        "title": "iOS开发-通知与推送",
        "url": "https://www.cctalk.com/m/group/87277429",
        "level": "中级",
        "technology": {
            "lan": "Swift",
            "editor": "Xcode",
            "framework": "UIKit"
        },
        "service": ["终生保价", "不定期更新"],
        "lessonCount": 59
    },
    {
        "id": 5,
        "title": "iOS开发-仿小红书实战课",
        "url": "https://www.cctalk.com/m/group/89152816",
        "level": "高级",
        "technology": {
            "lan": "Swift",
            "editor": "Xcode",
            "framework": "UIKit"
        },
        "service": ["终生保价", "永久更新"],
        "lessonCount": 465
    }
]
"""

let coursesJSONData: Data = coursesJSON.data(using: .utf8)!

struct Course: Codable {
    let id: Int
    let title: String
    let url: URL
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

do {
    let courses = try JSONDecoder().decode([Course].self, from: coursesJSONData)
    print(courses)
} catch {
    print(error)
}
