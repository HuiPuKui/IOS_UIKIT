import UIKit

let nums: [Int] = [1, 2, 3, 4, 5]
var sum = 0

// 第一种方式
for num in nums {
    sum += num
}

print(sum)


// 第二种方式
for num in 1...5 {
    print("我是天才 \(num)")
}


// 可以添加条件
// 单纯的想执行代码多少次可用闭区间; a...b 闭区间    a..<b 开区间
// where 是当 xxx 的意思; % 运算符: 取余数(取余 / 取模)
for i in 1...5 where i % 2 == 0 {
    print("我是天才 \(i)")
}


