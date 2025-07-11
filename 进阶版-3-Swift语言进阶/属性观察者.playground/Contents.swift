import UIKit

class Product {
    
    // 属性观察者用于:
    // 1. 当前类中新定义的或继承自父类的存储属性
    // 2. 继承自父类的计算属性（当前类中新定义的直接使用 setter ）
    
    var price: Double = 5000.0 {
        // 赋值前调用
        willSet(newPrice) {
            print("新值: \(newPrice)")
        }
        // 赋值后调用
        didSet {
            print("旧值: \(oldValue)")
            if price < 4000 {
                print("通知用户: 商品已经降价到了您的心里价位了")
            }
        }
    }
}

var product: Product = Product()
product.price = 3999

