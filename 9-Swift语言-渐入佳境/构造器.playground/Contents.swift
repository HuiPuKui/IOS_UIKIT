import UIKit

// 类的构造器 / 构造函数

// 默认构造器
class Car1 {
    var color: String = "black"
    var seats: Int = 5
}
let car1: Car1 = Car1()


// 指定构造器 Designated Intializers -- 可以有好几个
class Car2 {
    var color: String
    var seats: Int
    
    init(color: String, seats: Int) {
        self.color = color
        self.seats = seats
    }
}
let car2: Car2 = Car2(color: "black", seats: 5)


// 指定构造器覆盖默认构造器
class Car3 {
    var color: String = "black"
    var seats: Int = 5
    
    init(color: String, seats: Int) {
        self.color = color
        self.seats = seats
    }
}
let car3: Car3 = Car3(color: "red", seats: 2)


// 便利构造器 Convenience Initializers
class Car4 {
    var color: String
    var seats: Int
    
    init(color: String, seats: Int) {
        self.color = color
        self.seats = seats
    }
    
    // 便利构造器中需要调用指定构造器
    convenience init(color: String) {
        self.init(color: color, seats: 5)
    }
}
let car4: Car4 = Car4(color: "blue")
