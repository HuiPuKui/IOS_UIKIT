import UIKit

// 可选类型 Optional
// 包括两种值:
// 1. nil
// 2. 某个其它类型的值（如 Int, String, Array, Object, Enumeration 等）

// 完整写法
var name: Optional<String> = Optional("Lebus")
// 简写
var name1: String? = Optional("Lebus")
var name2: String? = "Lebus"

// 直接输出 Optional("Lebus")
print(name)
print(name1)
print(name2)

// 强制解包(fouced unwrapping)输出 Lebus
print(name!)
print(name1!)
print(name2!)

// 加一层保护
if name != nil {
    print(name!)
}

// 可选绑定 Optional Binding 第一种 -- iflet（判断是不是 nil，如果是 nil 就不会走大括号内的内容）
if let unwarppedName = name {
    print(unwarppedName)
}
// ↓ 等价于
if name != nil {
    let unwarppedName: String = name!
    print(unwarppedName)
}


// 可选绑定 Optional Binding 第二种 -- guard（判断是不是 nil，如果是 nil 就会走大括号内的内容）
// 只能在函数中写，因为需要 return
func demo(name: String?) -> Void {
    // ...
    guard let name = name else {
        return
    }
    
    // 如果 name 是 nil 的话，下面的代码就不会执行了
}



// 隐式可选类型(!) + 自动解包
// 一般在 class 里面声明可选属性时使用，表明在使用到他的时候一定有值（准确的说是在第一次使用到的时候）
// 和显示可选不同的是: 不需要再强制解包或可选绑定
// 类型！ 可能为nil(但我们认为不会)， 自动解包，使用场景：变量在init之后一定会有值，如IBOutlet
class Person {
    var name: String!
    init(name: String) {
        self.name = name
    }
}

let person = Person(name: "Alice")
print("输出内容是 ->", person.name)



