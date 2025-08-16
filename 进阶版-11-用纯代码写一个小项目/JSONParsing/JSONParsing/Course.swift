//
//  Course.swift
//  JSONParsing
//
//  Created by 惠蒲葵 on 2025/8/16.
//

import Foundation

struct Course: Codable {
    let title: String
    let service: [String]?
    let lessonCount: Int
    
    struct Technology: Codable {
        let lan: String
        let editor: String
        let framework: String
    }
}
