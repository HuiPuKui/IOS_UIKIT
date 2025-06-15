import UIKit

// 控制流
func love(hisName: String, herName: String) -> String {
    let num = Int.random(in: 0...100)
    if num > 80 {
        return "匹配度是: \(num)%, 你们之间相配, 祝百年好合"
    } else if num > 40 {
        return "匹配度是: \(num)%, 你们之间还可以, 仍需努力"
    } else {
        return "匹配度是: \(num)%, 你们之间没有可能, 不合适"
    }
}

print(love(hisName: "lebus", herName: "lebos"))
