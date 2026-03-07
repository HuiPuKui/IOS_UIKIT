//
//  NotificationTableVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/1.
//

import UIKit

class NotificationTableVC: UITableViewController {

    var isNotDetermined: Bool = false
    
    @IBOutlet weak var toggleAllowNotificationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.setSwitch(false)
                self.isNotDetermined = true
            case .denied:
                self.setSwitch(false)
            default:
                self.setSwitch(true)
            }
        }
    }

    @IBAction func toggleAllowNotification(_ sender: UISwitch) {
        if sender.isOn, self.isNotDetermined {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]
            ) { (granted, error) in
                if !granted {
                    self.setSwitch(false)
                }
            }
            self.isNotDetermined = false
        } else {
            jumpToSetting()
        }
    }
    
}

extension NotificationTableVC {
    
    private func setSwitch(_ on: Bool) {
        DispatchQueue.main.async {
            self.toggleAllowNotificationSwitch.setOn(on, animated: true)
        }
    }
    
}
