//
//  ViewController.swift
//  SentimentAnalysis
//
//  Created by 惠蒲葵 on 2025/9/14.
//

import UIKit
import CoreML
import NaturalLanguage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let model = try? NLModel(mlModel: spam(configuration: MLModelConfiguration()).model) else {
            fatalError("加载 mlmodel 失败")
        }
        
        if let str = model.predictedLabel(for: "feel free to call 021-55558888 for more information") {
            print(str)
        }
    }


}

