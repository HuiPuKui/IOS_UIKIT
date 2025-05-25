//
//  Constants.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/5/24.
//

import UIKit
import Foundation

let kTodoTableVCID: String = "TodoTableVCID"

let kTodoCellID: String = "TodoCellID"

let kAddTodoID: String = "AddTodoID"

func pointItem(_ iconName: String, _ pointSize: CGFloat = 22) -> UIImage? {
    let config = UIImage.SymbolConfiguration(pointSize: pointSize)
    return UIImage(systemName: iconName, withConfiguration: config)
}
