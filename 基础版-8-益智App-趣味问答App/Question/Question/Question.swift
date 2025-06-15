//
//  Question.swift
//  Question
//
//  Created by 惠蒲葵 on 2025/5/13.
//

import Foundation

class Question {
    
    var text: String
    
    var answer: Bool
    
    init(text: String, answer: Bool) {
        self.text = text
        self.answer = answer
    }
    
}

let questions: [Question] = [
    Question(text: "马云是中国首富", answer: false),
    Question(text: "刘强东最早是在中关村卖光盘的", answer: true),
    Question(text: "苹果公司是目前世界上最牛的科技公司", answer: true),
    Question(text: "只要坚持下去就能学好代码吗", answer: true),
    Question(text: "王思聪是80后", answer: true),
    Question(text: "在国内可以正常访问google.com吗", answer: false),
    Question(text: "敲完1万行代码之后可以成为编程高手吗", answer: true),
    Question(text: "撒贝宁说过清华也还行吗", answer: false),
    Question(text: "一直听Lebus的课可以变成大牛吗", answer: true),
    Question(text: "网上说苹果不好用安卓好用的人大多数都是水军吗", answer: true),
    Question(text: "豆瓣网是一个和你分享刚编的故事的网站吗", answer: false),
    Question(text: "优酷比B站牛", answer: false),
    Question(text: "我帅吗？", answer: true),
]
