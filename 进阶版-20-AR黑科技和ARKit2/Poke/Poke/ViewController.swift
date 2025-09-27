//
//  ViewController.swift
//  Poke
//
//  Created by 惠蒲葵 on 2025/9/27.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = ARReferenceImage.referenceImages(
            inGroupNamed: "Poke Cards",
            bundle: nil
        )
        configuration.maximumNumberOfTrackedImages = 1
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: any SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        
        DispatchQueue.main.async {
            let planceNode = SCNNode(
                geometry: SCNPlane(
                    width: imageAnchor.referenceImage.physicalSize.width,
                    height: imageAnchor.referenceImage.physicalSize.height
                )
            )
            planceNode.opacity = 0.25
            planceNode.eulerAngles.x = -.pi / 2
            
            guard let eeveeNode = SCNScene(named: "art.scnassets/eevee.scn")?.rootNode.childNode(withName: "eevee", recursively: true) else { return  }
            node.addChildNode(planceNode)
            node.addChildNode(eeveeNode)
        }
        
    }
    
}
