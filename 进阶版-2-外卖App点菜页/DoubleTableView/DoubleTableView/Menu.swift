//
//  Menu.swift
//  DoubleTableView
//
//  Created by 惠蒲葵 on 2025/6/16.
//

import Foundation

class Menu {
    var menuImageName: String
    var menuName: String
    var price: Double
    
    init(menuImageName: String, menuName: String, price: Double) {
        self.menuImageName = menuImageName
        self.menuName = menuName
        self.price = price
    }
}
