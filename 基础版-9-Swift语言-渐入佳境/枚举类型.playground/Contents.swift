import UIKit

// 枚举类型 Enumeration
enum CarType1 {
    case sedan
    case SUV
    case sports
}

// 成员值
let carType1: CarType1 = CarType1.sports
let carType2: CarType1 = .SUV

// 显式的取出枚举型数据的值
let alert1: UIAlertController = UIAlertController(title: "xx", message: "xxx", preferredStyle: UIAlertController.Style.alert)
// 隐式的取出枚举型数据的值
let alert2: UIAlertController = UIAlertController(title: "xx", message: "xxx", preferredStyle: .alert)


// 原始值
enum CarType2: String {
    case sedan = "sedan"
    case SUV = "SUV"
    case sports = "sports"
}
CarType2(rawValue: "SUV")

enum CarType3: Int {
    case sedan = 0
    case SUV
    case sports
}
print(CarType3.SUV.rawValue)

enum CarType4 {
    case sedan, SUV, sports
}
CarType4.sports

enum CarType5: Int {
    case sedan = 0, SUV, sports
}
CarType5.sports.rawValue

enum CarType6: Int {
    case sedan, SUV, sports
}
CarType6.sports.rawValue
