//
//  ViewController.swift
//  Question
//
//  Created by 惠蒲葵 on 2025/5/11.
//

import UIKit

// MVC - model, view, controller

class ViewController: UIViewController {
    
    var currentQuestionIndex: Int = 0

    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionLabel.text = questions[0].text
    }

    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            if questions[self.currentQuestionIndex].answer {
                print("回答正确")
            } else {
                print("回答错误")
            }
        } else {
            if questions[self.currentQuestionIndex].answer {
                print("回答错误")
            } else {
                print("回答正确")
            }
        }
        
        self.currentQuestionIndex += 1
        
        if self.currentQuestionIndex <= 12 {
            self.questionLabel.text = questions[self.currentQuestionIndex].text
        } else {
            self.currentQuestionIndex = 0 // reset
            
            let alert = UIAlertController(title: "漂亮!", message: "您已经完成了所有问题, 要重新来一遍吗?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "再来一遍", style: UIAlertAction.Style.default, handler: { _ in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}

