//
//  ViewController.swift
//  Measure
//
//  Created by 惠蒲葵 on 2025/9/27.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    
    var nodes: [SCNNode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.debugOptions = [.showFeaturePoints]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegete
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.nodes.count >= 2 {
            for node in nodes {
                node.removeFromParentNode()
            }
            
            self.nodes = []
            self.distanceLabel.text = "请选择终点"
        }
        
        guard let location = touches.first?.location(in: self.sceneView) else { return }
        guard let result = self.sceneView.hitTest(location, types: .featurePoint).first else { return }
        
        let position = result.worldTransform.columns.3
        
        let sphere = SCNSphere(radius: 0.005)
        sphere.firstMaterial?.diffuse.contents = UIColor.yellow
        let node = SCNNode(geometry: sphere)
        node.position = SCNVector3(x: position.x, y: position.y, z: position.z)
        self.sceneView.scene.rootNode.addChildNode(node)
        
        self.nodes.append(node)
        if self.nodes.count >= 2 {
            let p1 = self.nodes[0].position
            let p2 = self.nodes[1].position
            let distance = abs(sqrt(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2) + pow((p1.z - p2.z), 2)))
            self.distanceLabel.text = String(distance)
        }
    }
    
}
