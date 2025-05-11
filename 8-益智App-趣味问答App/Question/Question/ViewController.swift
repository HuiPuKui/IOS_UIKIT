//
//  ViewController.swift
//  Question
//
//  Created by 惠蒲葵 on 2025/5/11.
//

import UIKit

class Question {
    
    var text: String
    
    var answer: Bool
    
    init(text: String, answer: Bool) {
        self.text = text
        self.answer = answer
    }
    
}

class ViewController: UIViewController {
    
    let questions: [Question] = [
        Question(text: "马云是中国首富", answer: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

