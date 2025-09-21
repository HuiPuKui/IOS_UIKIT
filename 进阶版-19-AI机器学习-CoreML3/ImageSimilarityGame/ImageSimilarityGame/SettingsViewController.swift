//
//  SettingsViewController.swift
//  ImageSimilarityGame
//
//  Created by 惠蒲葵 on 2025/9/21.
//

import UIKit

let kSettingsContestDurationKey = "contestDuration"

class SettingsViewController: UIViewController {

    let durations = [0, 15, 30, 45, 60]
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncToUserDefaults()
    }
    
    private func syncToUserDefaults() {
        let duration = UserDefaults.standard.integer(forKey: kSettingsContestDurationKey)
        if let index = durations.firstIndex(of: duration) {
            picker.selectRow(index, inComponent: 0, animated: false)
        }
    }

    @IBAction func done(_ sender: Any) {
        let duration = durations[picker.selectedRow(inComponent: 0)]
        UserDefaults.standard.set(duration, forKey: kSettingsContestDurationKey)
        dismiss(animated: true)
    }
    
}

extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: "\(durations[row])", attributes: [.foregroundColor: UIColor.black])
    }
    
}
