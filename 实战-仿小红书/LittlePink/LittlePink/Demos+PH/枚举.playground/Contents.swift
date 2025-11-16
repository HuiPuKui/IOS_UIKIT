import UIKit

// MARK: - 语法
enum CompassPoint {
    case north
    case south
    case east
    case west
}

var directionToHead: CompassPoint = .east
directionToHead = .north


// MARK: - 遍历
enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available") // Prints "3 beverages available"

for beverage in Beverage.allCases {
    print(beverage)
}


// MARK: - 原始值 Raw Values
// 赋值什么类型就要遵循什么协议
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
print(ASCIIControlCharacter.tab.rawValue)

// 隐式的给 case 赋原始值
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
print(Planet.earth.rawValue)

enum CompassPointString: String {
    case north, south, east, west
}
print(CompassPointString.north.rawValue)

Planet.uranus
Planet(rawValue: 7)


// MARK: - 关联值 Associated Values
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

// 判断并取出关联值
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode)")
}

// 判断并取出关联值的简写
if case let .qrCode(productCode) = productBarcode {
    print(productCode)
}

