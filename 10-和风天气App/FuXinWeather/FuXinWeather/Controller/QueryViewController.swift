//
//  QueryViewController.swift
//  FuXinWeather
//
//  Created by 惠蒲葵 on 2025/5/20.
//

import UIKit

// delegate -- 代理/委托
// protocol -- 协议（optional 可选实现）

protocol QueryViewControllerDelegate {
    
    func didChangeCity(city: String);
    
}

class QueryViewController: UIViewController {

    var currentCity: String = ""
    var delegate: QueryViewControllerDelegate?
    
    @IBOutlet weak var currentCityLabel: UILabel!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 弹出软键盘
        self.cityTextField.becomeFirstResponder()
        /*
            // 收起软键盘
            self.cityTextField.resignFirstResponder()
         */
        
        self.currentCityLabel.text = self.currentCity
    }

    @IBAction func back(_ sender: Any) {
        // 消失
        self.dismiss(animated: true)
    }
    
    @IBAction func query(_ sender: Any) {
        // 消失
        self.dismiss(animated: true)
        
        // 删除空格判断是否为空
        if !self.cityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.delegate?.didChangeCity(city: self.cityTextField.text!)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
