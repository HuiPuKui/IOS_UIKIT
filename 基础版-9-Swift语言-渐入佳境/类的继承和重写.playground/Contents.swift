import UIKit

// 继承 inherit

// 动物 父类/基类 super class
class Animal {
    func breathe() -> Void {
        print("在空气呼吸")
    }
}

// 哺乳动物 子类/派生类 subclass
class Mammal: Animal {
    var hasHair: Bool = true
}

let animal: Mammal = Mammal()
animal.breathe()
animal.hasHair

// 人类
class Person: Mammal {
    func useComputer() -> Void {
        
    }
}

let person: Person = Person()
person.breathe()
person.hasHair
person.useComputer()


// 重写 override
class Fish: Animal {
    override func breathe() {
        super.breathe()
        print("在水中呼吸")
    }
}

let fish: Fish = Fish()
fish.breathe()
