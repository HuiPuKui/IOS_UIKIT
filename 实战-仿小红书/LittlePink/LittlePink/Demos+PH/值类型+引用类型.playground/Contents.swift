import UIKit

// 内存的两个分块: 1. 堆-heap; 2. 栈-stack
// 指针=内存地址

// Swift 中只有三种类型是引用类型
// 1. 对象
// 2. 函数
// 3. 闭包

// Swift 中的值类型
// 1. 结构体 (可以包含 Int, Float ...)
// 2. 枚举
// 3. 元组

// MARK: 结构体
struct PersonS {
    var name: String = "小王"
    var age: Int = 20
}

let p1 = PersonS()
var p2 = p1

p2.age = 30
print(p1, p2)

// MARK: 类
class PersonC {
    var name: String = "小王"
    var age: Int = 20
}

let p3 = PersonC()
let p4 = p3
p4.age = 30
print(p3, p4)
