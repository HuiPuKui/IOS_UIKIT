import UIKit
 
func getMilk() -> Void {
    print("去商店")
    print("买一箱牛奶")
    print("给 10 块钱")
    print("回家")
}

getMilk()


// nums -> 形式参数 / 形参
func getMilk(nums: Int) -> Void {
    let price = 10 * nums
    
    print("去商店")
    print("买 \(nums) 箱牛奶")
    print("给 \(price) 块钱")
    print("回家")
}

// nums -> 实际参数 / 实参
getMilk(nums: 1)
getMilk(nums: 4)


func getMilk(nums: Int, total: Int) -> Int {
    let price = 10 * nums
    let res = total - price
    
    print("去商店")
    print("买 \(nums) 箱牛奶")
    print("给 \(price) 块钱")
    print("回家")
    
    return res
}

let res = getMilk(nums: 1, total: 100)
print("还剩 \(res) 块钱")
