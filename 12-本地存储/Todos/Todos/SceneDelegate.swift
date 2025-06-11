//
//  SceneDelegate.swift
//  Todos
//
//  Created by 惠蒲葵 on 2025/5/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        print("若使用IB，则自动创建可视窗口；若不使用IB，则可在此利用window属性（可视窗口），然后用代码设定App的首页vc")
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("窗口/App已经断开连接（1.关闭App时调用， 2.退到后台后不久调用）")
    }

    // App 主要有三种状态：被关闭，在前台，在后台
    
    // 下面两个方法对应的范围更广，如App关闭时，用户点击推送横幅后打开App，也会调用sceneDidBecomeActive，此时可清除右上角角标
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("窗口/App从非活跃 --> 活跃（已经被激活）")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("窗口/App从活跃 --> 非活跃（即将被挂起）")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("窗口/App从后台 --> 前台（即将回到前台）")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        print("窗口/App从前台 --> 后台（已经进入后台）")
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

