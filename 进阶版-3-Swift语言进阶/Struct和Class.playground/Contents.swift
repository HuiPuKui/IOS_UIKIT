import UIKit

// 内存:栈(stack), 堆(heap)

struct StructPerson {
    var name: String
    var gender: String
    
    mutating func changeName(name: String) { // 不加 mutating 报错: Cannot assign to property: 'self' is immutable
        self.name = name
    }
}
// 值类型 - value type - 直接存在栈中
// 优点: 简单，快，可以深拷贝，真正的不变性，不会内存泄露
var structPerson1 = StructPerson(name: "张三", gender: "男")
var structPerson2 = structPerson1 // 深拷贝
structPerson2.name = "张大花"

print(structPerson1)
print(structPerson2)

/*
 值类型，let 不可修改
 
 let a: Int = 1
 a = 3
 let structPerson3 = StructPerson(name: "李四", gender: "男")
 structPerson3.name = "李大花"
 */


class ClassPerson {
    var name: String
    var gender: String
    init(name: String, gender: String) {
        self.name = name
        self.gender = gender
    }
    
    func changeName(name: String) {
        self.name = name
    }
}
// 引用类型 - reference type - 在栈中存储的是它的引用地址(真正存在堆中)
// 优点: 可以继承
var classPerson1 = ClassPerson(name: "张三", gender: "男")
var classPerson2 = classPerson1 // 浅拷贝
classPerson2.name = "张大花"

print(classPerson1.name)
print(classPerson2.name)

/*
 引用类型，let 仍旧可以修改常量下面的属性，因为本身是指针
 let classPerson3 = ClassPerson(name: "李四", gender: "男")
 classPerson3.name = "李大花"
 
 但是修改本身是不允许的
 classPerson3 = classPerson1(不可以)
 */
