import UIKit

// MARK: - 语法 -- 代码执行块
//{ (parameters) -> return type in
//    statements
//}

// MARK: - 使用场景1 -- 全局函数
// 直接调用
let label: UILabel = {
    let label = UILabel()
    label.text = "xxx"
    return label
}()

// 先定义，再调用
let learn = { (language: String) -> String in
    return "学习 \(language)"
}
learn("Swift")

// 和函数的区别
func learn1(_ language: String) -> String {
    return "学习 \(language)"
}
learn1("Swift")

// 定义类型
let aa: Int?
let bb: (() -> ())?
let cc: (() -> Void)?

// MARK: - 使用场景2 -- 嵌套函数(重要)
func codingSwift(day: Int, appName: () -> String) {
    print("学习 Swift \(day) 天了, 写了 \(appName()) App")
}

// 传参时直接写闭包
codingSwift(day: 40, appName: { () -> String in
    return "天气"
})

// 传参时写已经写好了的闭包'名'
let appName = { () -> String in
    return "Todos"
}
codingSwift(day: 60, appName: appName)

// 传参时写已经写好了的函数名(需参数和返回值的个数和类型完全一样)
func appName1() -> String {
    return "计算器"
}
codingSwift(day: 100, appName: appName1)

// MARK: - 简写方法1 -- 尾随闭包 Trailing Closure

codingSwift(day: 130) { () -> String in
    return "机器学习"
}

// MARK: - 简写方法2 -- 根据上下文推断类型

func codingSwift(day: Int, appName: String, res: (Int, String) -> String) {
    print("学习 Swift \(day) 天了，\(res(1, "Alamofire"))，做成了 \(appName) App")
}

codingSwift(day: 40, appName: "天气") { takeDay, use in
    return "花了 \(takeDay) 天，使用了 \(use) 技术"
}

codingSwift(day: 40, appName: "天气") {
    "花了 \($0) 天，使用了 \($1) 技术"
}

// MARK: - 系统函数案例 -- sorted

let arr = [3, 5, 1, 2, 4]
let sortedArr1 = arr.sorted { $0 < $1 }
let sortedArr2 = arr.sorted(by: <)

// MARK: - 闭包捕获

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    /*
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
     */
    let incrementer = { () -> Int in
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incrementBySeven()
incrementBySeven()

// MARK: - 闭包时引用类型

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

incrementByTen()
