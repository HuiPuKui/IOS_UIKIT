//
//  ViewController.swift
//  PeopleOcclusion
//
//  Created by 刘军 on 2020/3/22.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    
    @IBOutlet var arView: ARView!
    @IBOutlet weak var messageLabel: RoundedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //RealityKit中固定用法--先加一个AnchorEntity，其实就是先加个虚拟的大场景
        let anchorEntity = AnchorEntity(plane: .horizontal, minimumBounds: [0.1, 0.1])
        arView.scene.anchors.append(anchorEntity)
        
        //加载3D模型
        let toy = try! ModelEntity.load(named: "toy")
        toy.scale = [1, 1, 1] * 0.006
       
        //3D模型放进大场景（anchorEntity）中
        anchorEntity.children.append(toy)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //当前App的做法：不支持的话就停止运行程序。你也可以不支持的话就照常运行，只不过没有人物遮挡功能
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else { return }
        
        guard let config = arView.session.configuration as? ARWorldTrackingConfiguration else { return }
        
        //开启人物遮挡功能
        //personSegmentationWithDepth是指只有当人物比虚拟物体更接近相机时才遮挡虚拟物体--符合现实世界规律
        config.frameSemantics.insert(.personSegmentationWithDepth)
        
        arView.session.run(config)
    }
    
    @IBAction func onTap(tap: UITapGestureRecognizer){
        
        guard let config = arView.session.configuration as? ARWorldTrackingConfiguration else { return }
        
        switch config.frameSemantics {
        case .personSegmentationWithDepth:
            config.frameSemantics.remove(.personSegmentationWithDepth)
            messageLabel.displayMessage("人物遮挡已关闭", 5)
        default:
            config.frameSemantics.insert(.personSegmentationWithDepth)
            messageLabel.displayMessage("人物遮挡已开启", 5)
        }
        
        arView.session.run(config)
    }
    
}
