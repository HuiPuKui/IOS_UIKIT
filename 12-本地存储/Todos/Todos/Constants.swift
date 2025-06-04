//
//  Constants.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/5/24.
//

import UIKit
import Foundation

// storyboardID
let kTodoTableVCID: String = "TodoTableVCID"

// cellID
let kTodoCellID: String = "TodoCellID"

// segueID
let kAddTodoID: String = "AddTodoID"
let kEditTodoID: String = "EditTodoID"

// userdefault key
let kTodosKey = "TodosKey"

func pointItem(_ iconName: String, _ pointSize: CGFloat = 22) -> UIImage? {
    let config = UIImage.SymbolConfiguration(pointSize: pointSize)
    return UIImage(systemName: iconName, withConfiguration: config)
}
