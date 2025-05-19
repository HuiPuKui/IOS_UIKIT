import UIKit

let xx = 20
// Int 或 Double 转字符串的两种方法
let yy = "\(xx)"
let zz = String(xx)

// Double 转 Int (去掉小数点后面的)
Int(1.9)
// Int 转 Double
Double(1)
// 四舍五入
round(1.2)
round(1.6)

class A {
    
}

class B: A {
    
}

let a: A = A()
let b: B = B()

// as --> 向上转型 upcasting -- 用的少
// as? --> 向下转型 downcasting -- 可能为空的情况下使用, 要用 iflet
// as! --> 向下转型 downcasting -- 强制转换类型, 在明确的情况下使用
b as A // 向上转型
a as? B // 向下转型 尝试转换 不成功返回 nil
a as! B // 向下转型 强制转换（这个会报错）
