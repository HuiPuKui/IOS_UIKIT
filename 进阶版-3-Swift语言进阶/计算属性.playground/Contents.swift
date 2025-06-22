import UIKit

/* 1-3
// 长方形
struct Rect {
    var originX: Double
    var originY: Double
    var width: Double
    var height: Double
    
    var centerX: Double {
        get {
            let centerX = originX + width / 2
            return centerX
        }
        set(newCenterX) {
            originX = newCenterX - width / 2
        }
    }
    
    var centerY: Double {
        get {
            let centerY = originY + height / 2
            return centerY
        }
        set(newCenterY) {
            originY = newCenterY - height / 2
        }
    }

    /*
     面积，只读
     等价于
     var area: Double {
        width * height
     }
     */
    var area: Double {
        get {
            return width * height
        }
    }
    
}

var square: Rect = Rect(originX: 0, originY: 0, width: 10, height: 10)
// 触发 get 里的代码
let initialSquareCenterX: Double = square.centerX
let initialSquareCenterY: Double = square.centerY

print(initialSquareCenterX, initialSquareCenterY)

// 触发 set 里的代码
square.centerX = 15
square.centerY = 15

print(square.originX)
print(square.originY)
print(square.area)
 */

// 存储属性用于 class, struct
// 计算属性用于 class, struct, enum
struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

struct Rect {
    var origin: Point = Point()
    var size: Size = Size()
    var center: Point {
        get {
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - size.width / 2
            origin.y = newCenter.y - size.height / 2
        }
    }
}

var square: Rect = Rect(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
// 触发 get
let initialSquareCenter: Point = square.center
print(initialSquareCenter.x, initialSquareCenter.y)
// 触发 set
square.center = Point(x: 15, y: 15)
print(square.origin.x, square.origin.y)
