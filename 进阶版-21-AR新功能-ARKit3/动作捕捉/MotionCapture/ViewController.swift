//
//  ViewController.swift
//  MotionCapture
//
//  Created by 刘军 on 2020/3/23.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit
import RealityKit
import ARKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    let bodyAnchorEntity = AnchorEntity()
    var bodyTrackedEntity: BodyTrackedEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard ARBodyTrackingConfiguration.isSupported else { return }
        
        arView.session.delegate = self
        
        arView.scene.addAnchor(bodyAnchorEntity)
        
        var cancellable: AnyCancellable?
        cancellable = Entity.loadBodyTrackedAsync(named: "robot")
            .sink(
                receiveCompletion: { completion in
                    //switch completion{
                    //    case .finished:
                    //    print("xxx")
                    //    case .failure(let error):
                    //    print("加载模型失败：\(error.localizedDescription)")
                    //}
                    //上面的简写
                    if case let .failure(error) = completion {
                        print("加载模型失败：\(error.localizedDescription)")
                    }
                    
                    cancellable?.cancel()
                }
            ) { bodyTrackedEntity in
                bodyTrackedEntity.scale = [1, 1, 1]
                self.bodyTrackedEntity = bodyTrackedEntity
                
                cancellable?.cancel()
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        arView.session.run(ARBodyTrackingConfiguration())
    }
}

extension ViewController: ARSessionDelegate{
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors{
            guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
            
            //根据检测到的锚点里面的信息设定虚拟物体的大小(scale)，位置(position)，方向(orientation)
            //锚点的transform属性包含所有信息(矩阵)，用它实例化Transform; --RealityKit新功能
            //依次可获取对应的大小(scale)，位置(translation)，方向(rotation) --RealityKit新功能
            
            //设定机器人的位置
            bodyAnchorEntity.position = Transform(matrix: bodyAnchor.transform).translation + [-1, 0, 0]
            
            //设定机器人的方向
            bodyAnchorEntity.orientation = Transform(matrix: bodyAnchor.transform).rotation
            
            
            if let bodyTrackedEntity = bodyTrackedEntity, bodyTrackedEntity.parent == nil{
                bodyAnchorEntity.addChild(bodyTrackedEntity)
            }
        }
    }
}
