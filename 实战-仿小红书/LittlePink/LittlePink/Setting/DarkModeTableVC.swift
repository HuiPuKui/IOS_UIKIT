//
//  DarkModeTableVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/4.
//

import UIKit

class DarkModeTableVC: UITableViewController {

    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var followSystemSwitch: UISwitch!
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        return self.traitCollection.userInterfaceStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.darkModeSwitch.isOn = self.userInterfaceStyle == .dark
        self.followSystemSwitch.isOn = UserDefaults.standard.integer(forKey: kUserInterfaceStyle) == 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.followSystemSwitch.isOn {
            UserDefaults.standard.set(0, forKey: kUserInterfaceStyle)
        } else {
            UserDefaults.standard.set(self.darkModeSwitch.isOn ? 2 : 1, forKey: kUserInterfaceStyle)
        }
    }
    
    @IBAction func toggle(_ sender: Any) {
        self.followSystemSwitch.setOn(false, animated: true)
        self.setUserInterfaceStyle()
    }
    
    @IBAction func followSystem(_ sender: Any) {
        if self.followSystemSwitch.isOn {
            self.view.window?.overrideUserInterfaceStyle = .unspecified
            self.darkModeSwitch.setOn(self.userInterfaceStyle == .dark, animated: true)
        } else {
            self.setUserInterfaceStyle()
        }
    }
    
    private func setUserInterfaceStyle() {
        self.view.window?.overrideUserInterfaceStyle = self.darkModeSwitch.isOn ? .dark : .light
    }

}
