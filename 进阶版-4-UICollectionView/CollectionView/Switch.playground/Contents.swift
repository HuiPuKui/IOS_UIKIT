import UIKit

var index = 10

if index == 100 {
    print("index的值为100")
} else if index == 10 {
    print("index的值为10")
} else {
    print("index的值为其他")
}

switch index {
    case 100:
        print("index的值为100")
    case 10:
        print("index的值为10")
    default:
        print("index的值为其他")
}
