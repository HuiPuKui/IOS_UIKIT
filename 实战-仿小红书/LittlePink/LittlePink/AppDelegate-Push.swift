//
//  AppDelegate-Push.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/7.
//

import Foundation
import LeanCloud

extension AppDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        LCApplication.default.currentInstallation.set(
            deviceToken: deviceToken,
            apnsTeamId: "T4K3TACYPH"
        )
        
        LCApplication.default.currentInstallation.save { _ in }
    }
    
}
