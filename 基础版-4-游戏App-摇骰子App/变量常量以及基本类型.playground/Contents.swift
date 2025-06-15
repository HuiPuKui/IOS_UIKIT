import UIKit

// Int Float Double String Bool

// 1. 可以自动进行类型推断
var greeting = "Hello, playground"
// 等价于: var greeting: String = "Hello, playground"

var index1 = 0
// 等价于: var index1: Int = 0

// 2. 数字类型的数据可数学运算(+,-,*,/), 且左右两边需为同一类型
index1 + 1

// 3. 小数默认为 Double 类型
var num1 = 0.1
// 等价于: var num1: Double = 0.1

// 4. 布尔类型
var flag: Bool = true // var flag: Bool = false

// 5. 字符串的加法运算 - 字符串拼接 - 现在用的少
greeting + " lebus"
// 等价于: "\(greeting) lebus"

// 6. 常量 let (第一次赋值之后不可更改)
let name: String = "lebus"
// 错误: name = "liu" // 常量不能更改

/*
 // 可以
 let name: String
 name = "liu"
 */
