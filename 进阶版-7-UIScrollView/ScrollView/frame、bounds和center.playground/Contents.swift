import UIKit

let someView = UIView()

// UIView 的 frame，bounds 属性
CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100))
CGRect(x: 0, y: 0, width: 100, height: 100)
someView.frame // 在父视图坐标体系中的位置和大小
someView.bounds // 在自身坐标体系中的位置和大小

// 位置（即x轴y轴坐标）（如origin，center）
CGPoint(x: 0, y: 0) // x和y都是0坐标也可以写成 CGPoint.zero
someView.frame.origin
someView.bounds.origin
someView.center // 在父视图坐标体系中的中心点的位置

// 大小（即宽和高）
CGSize(width: 100, height: 100) // 宽高都是 0 也可以写成 CGSize.zero
someView.frame.size
someView.bounds.size
someView.frame.width // 仅可读
someView.frame.size.width // 可读可写
