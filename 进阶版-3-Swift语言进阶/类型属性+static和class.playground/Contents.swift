import UIKit

struct User {
    var name: String = "张三"
    static let standard: User = User()
}

User.standard

// 类型属性: 静态属性（static前缀）+ 类属性（class前缀）
// static 虽然可以在类、结构体、或者枚举中使用，且可以修饰存储属性、计算属性和方法，非常通用，但它修饰的计算属性不能被重写
// class 虽然只能在类中使用，却只顾被曝光修饰类中的计算属性和方法，但修饰的计算属性和方法可以被重写（如Bundle的main属性，UserDefault的standard属性）

// 总结: 如无重写需求，则统一使用static，性能更高
