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
        let installation = LCApplication.default.currentInstallation
        
        installation.set(
            deviceToken: deviceToken,
            apnsTeamId: "T4K3TACYPH"
        )
        
        if installation.get(kUserCol) == nil, let user = LCApplication.default.currentUser {
            try? installation.set(kUserCol, value: user)
        }
        
        installation.save { _ in }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let noteID = userInfo["noteID"] as? String {
            let query = LCQuery(className: kNoteTable)
            query.whereKey(kAuthorCol, .included)
            
            UIViewController.showGlobalLoadHUD()
            query.get(noteID) { res in
                UIViewController.hideGlobalHUD()
                if case let .success(object: note) = res {
                    guard
                        let scene = UIApplication.shared.connectedScenes.first,
                        let sceneDelegate = scene.delegate as? SceneDelegate,
                        let window = sceneDelegate.window,
                        let rootVC = window.rootViewController as? UITabBarController
                    else { return }
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let detailVC = storyboard.instantiateViewController(identifier: kNoteDetailVCID) { coder in
                        return NoteDetailVC(coder: coder, note: note)
                    }
                    detailVC.modalPresentationStyle = .fullScreen
                    detailVC.isFromPush = true
                    rootVC.selectedViewController?.present(detailVC, animated: true)
                }
            }
        }
        
        completionHandler()
    }
    
}
