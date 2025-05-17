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
    
    var score: Int = 0

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var progressBarViewWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionLabel.text = questions[0].text
    }

    @IBAction func answerPressed(_ sender: UIButton) {
        self.checkAnswer(sender.tag)
        
        self.currentQuestionIndex += 1
        
        self.nextQuestion()
        
        self.updateProgress()
    }
    
    func checkAnswer(_ tag: Int) -> Void {
        if tag == 1 {
            if questions[self.currentQuestionIndex].answer {
                print("回答正确")
                ProgressHUD.showSuccess("答对了")
                self.score += 1
                self.updateScoreLabel()
            } else {
                print("回答错误")
                ProgressHUD.showError("答错了")
            }
        } else {
            if questions[self.currentQuestionIndex].answer {
                print("回答错误")
                ProgressHUD.showError("答错了")
            } else {
                print("回答正确")
                ProgressHUD.showSuccess("答对了")
                self.score += 1
                self.updateScoreLabel()
            }
        }
    }
    
    func nextQuestion() -> Void {
        if self.currentQuestionIndex <= 12 {
            self.updateQuestionText()
        } else {
            self.currentQuestionIndex = 0 // reset
            self.score = 0
            
            // handler 和 completion 参数为闭包/回调函数，一般用在一怎么怎么就怎么怎么
            let alert: UIAlertController = UIAlertController(title: "漂亮!", message: "您已经完成了所有问题, 要重新来一遍吗?", preferredStyle: UIAlertController.Style.alert)
            
            // alert 下面的按钮
            let action: UIAlertAction = UIAlertAction(title: "再来一遍", style: UIAlertAction.Style.default, handler: { action in
                self.updateQuestionText()
                
                self.updateScoreLabel()
            })
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func updateQuestionText() -> Void {
        self.questionLabel.text = questions[self.currentQuestionIndex].text
    }
    
    func updateScoreLabel() -> Void {
        self.scoreLabel.text = "总得分: \(self.score)"
    }
    
    func updateProgress() -> Void {
        self.progressLabel.text = "\(self.currentQuestionIndex + 1) / 13"
        self.progressBarViewWidth.constant = (self.view.frame.width / 13) * CGFloat(self.currentQuestionIndex)
    }
}

