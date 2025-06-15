import UIKit

func calcBMI(weight: Double, height: Double) -> String {
    let bmi: Double = round(weight / pow(height, 2))
    var message: String = ""
    
    if bmi > 25 {
        message = "你太胖了"
    } else if bmi > 18.5 {
        message = "你的身体很健康"
    } else {
        message = "你太廋了"
    }
    
    return "BMI是：\(bmi), \(message)"
}

print(calcBMI(weight: 69.5, height: 1.8))


// 外部参数, 内部参数, 当外部参数为 _ 调用时外部参数不显示
// 函数可重名的情况: 1. 参数数量或类型不同    2. 参数名不同(包括外部参数和内部参数)
func calcBMI(use weight: Double, and height: Double) -> String {
    let bmi: Double = round(weight / pow(height, 2))
    var message: String = ""
    
    if bmi > 25 {
        message = "你太胖了"
    } else if bmi > 18.5 {
        message = "你的身体很健康"
    } else {
        message = "你太廋了"
    }
    
    return "BMI是：\(bmi), \(message)"
}

print(calcBMI(use: 69.5, and: 1.8))
