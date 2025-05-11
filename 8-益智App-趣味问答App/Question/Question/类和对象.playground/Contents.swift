import UIKit

let arr:[Int] = [1, 2, 3, 4]

// 类
class Person {
    
    // 属性 property
    var name: String
    
    // 初始化函数 / 初始化构造器
    init(_ name: String) {
        self.name = name
    }
    
    // 方法 method
    func walk() -> Void {
        print("走路")
    }
    
}

// 实例化 / 初始化
let person1 = Person("李四")
print(person1.name)
person1.walk()

let person2 = Person("张三")
print(person2.name)
person2.walk()
