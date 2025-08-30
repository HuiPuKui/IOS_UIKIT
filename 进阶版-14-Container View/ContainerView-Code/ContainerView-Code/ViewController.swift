//
//  ViewController.swift
//  ContainerView-Code
//
//  Created by 惠蒲葵 on 2025/8/30.
//

import UIKit

class ViewController: UIViewController {

    private lazy var playerVC: PlayerVC = storyboard!.instantiateViewController(withIdentifier: "playerVC") as! PlayerVC
    private lazy var tableVC: TableVC = storyboard!.instantiateViewController(withIdentifier: "tableVC") as! TableVC
    
    // 用 约束 的方式
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(self.playerVC)
        addChild(self.tableVC)
        
        let playerView = self.playerVC.view!
        let tableView = self.tableVC.tableView!
        let safeArea = self.view.safeAreaLayoutGuide
        
        // 必须先 addSubview 再定约束
        self.view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            playerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 8)
        ])
        
        self.playerVC.didMove(toParent: self)
        self.tableVC.didMove(toParent: self)
    }

    // 不太优雅的方式
    override func viewDidLayoutSubviews() {
//        addChild(self.playerVC)
//        addChild(self.tableVC)
//        
//        self.playerVC.view.frame.size.width = self.view.safeAreaLayoutGuide.layoutFrame.width
//        self.playerVC.view.frame.size.height = 300
//        self.playerVC.view.frame.origin = self.view.safeAreaLayoutGuide.layoutFrame.origin
//        self.view.addSubview(self.playerVC.view)
//        
//        self.playerVC.didMove(toParent: self)
//        self.tableVC.didMove(toParent: self)
    }

}

