import UIKit
import RealityKit
import ARKit
import MultipeerConnectivity

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    @IBOutlet weak var messageLabel: MessageLabel!
    @IBOutlet weak var restartButton: UIButton!
    
    var multipeerSession: MultipeerSession?
    
    let configuration = ARWorldTrackingConfiguration()
    let coachingOverlay = ARCoachingOverlayView()
    
    // MCPeerID为key，ARSessionID为value的字典，可用于实时得知当前的ARAnchor是哪个玩家创建的
    var peerSessionIDs = [MCPeerID: String]()
    
    var sessionIDObservation: NSKeyValueObservation?
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        arView.session.delegate = self
        
        // 使用自定义配置
        arView.automaticallyConfigureSession = false
        
        setupCoachingOverlay()
        
        // 在世界追踪session中开启合作功能--iOS13新功能
        // 合作session中，ARKit会定期提供数据(环境+别的玩家的锚点)供联机玩家共享
        // 这些数据需通过网络协议发送出去--这里使用短距离通信协议MultipeerConnectivity
        configuration.isCollaborationEnabled = true
        
        // 环境纹理设为自动(基于图像照明算法，真实地反射周围环境的光线，使虚拟模型更逼真)
        configuration.environmentTexturing = .automatic
        
        // 防止屏幕变暗让体验变差--禁用idle timer避免因屏幕无交互后的系统自动睡眠
        UIApplication.shared.isIdleTimerDisabled = true
        
        arView.session.run(configuration)
        
        // 使用观察者模式(key-value observation)实时监测SessionID的变化--类似属性观察者(willset,didset)
        sessionIDObservation = observe(\.arView.session.identifier, options: [.new]) { vc, change in
            print("SessionID变成了: \(change.newValue!)")
            // 一旦改变SessionID后，告诉其他联机玩家，以便他们能够追踪到最新的ARAnchor
            guard let multipeerSession = self.multipeerSession else { return }
            self.sendARSessionIDTo(peers: multipeerSession.connectedPeers)
        }
        
        // 通过MultiPeerConnectivity框架寻找别的玩家
        multipeerSession = MultipeerSession(
            receivedDataHandler: receivedData,
            peerJoinedHandler:peerJoined,
            peerLeftHandler: peerLeft,
            peerDiscoveredHandler: peerDiscovered
        )
        
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
        
        messageLabel.displayMessage("邀请其他人启动此应用以加入\n联机后试一试点击屏幕以放置立方体模型", duration: 60.0)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: arView)
        
        // 在用户触摸位置的水平面上找到位置数据
        // raycast为hit-testing的升级版
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult = results.first {
            // 在触摸位置添加一个带有name的ARAnchor，之后将在“session_：didAdd :)”中对应该name
            let anchor = ARAnchor(name: "Anchor for object placement", transform: firstResult.worldTransform)
            arView.session.add(anchor: anchor)
        } else {
            messageLabel.displayMessage("没有找到平面无法放置物体\n请寻找平坦表面", duration: 6.0)
        }
    }
    
    //MC网络连接成功后-新玩家加入
    //1-1：
    //ARKit为了知道两个玩家之间的相对位置，它必须要先合并各自的世界地图(相机捕捉到的现实环境)
    //合并成功(即所有玩家一开始需把iPhone相机面向同一个地方)后可共享玩家们各自的位置以及创建的锚点
    //通过didAddanchors的delegate方法，提供自己的ARParticipantAnchor(自己的iPhone锚)，等合并成功后对方即可看到我的坐标球
    //1-2：
    //给B发送我(A)的MCPeerID和SessionID数据--MCSession中处理
    func peerJoined(_ peer: MCPeerID) {
        messageLabel.displayMessage("一个新玩家想加入游戏，请将双方iPhone并排靠近以面向同一个现实环境", duration: 12.0)
        // 向B提供你的SessionID，以便他们可以跟踪你的锚点
        sendARSessionIDTo(peers: [peer])
    }
    
    // 3-此处会接收两种数据：
    // 系统调用didOutputCollaborationData之后，我们通过MC网络发送的CollaborationData数据
    // 通过MC网络手动send的数据(见peerJoined函数)--“SessionID:xxx”
    func receivedData(_ data: Data, from peer: MCPeerID) {
        if let collaborationData = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARSession.CollaborationData.self, from: data) {
            // 接收别的玩家的CollaborationData后需调用此方法以更新session
            arView.session.update(with: collaborationData)
            return
        }
        
        let sessionIDCommandString = "SessionID:"
        // data解码后变成的字符串若以“SessionID:”为开头，则取出“SessionID:”后面的字串（详见playground）
        if let commandString = String(data: data, encoding: .utf8), commandString.starts(with: sessionIDCommandString) {
            let newSessionID = String(
                commandString[
                    commandString.index(commandString.startIndex,offsetBy: sessionIDCommandString.count)...
                ]
            )
            // 如果当前过来联机的玩家之前使用的是不同的sessionID，则删除所有相关anchor
            if let oldSessionID = peerSessionIDs[peer] {
                removeAllAnchorsOriginatingFromARSessionWithID(oldSessionID)
            }
            
            peerSessionIDs[peer] = newSessionID
        }
    }
    
    //4-连接断开(玩家离开)
    func peerLeft(_ peer: MCPeerID) {
        messageLabel.displayMessage("一个玩家离开了游戏")
        
        // 删除和刚刚离开的玩家相关的所有锚点
        if let sessionID = peerSessionIDs[peer] {
            removeAllAnchorsOriginatingFromARSessionWithID(sessionID)
            peerSessionIDs.removeValue(forKey: peer)
        }
    }

    @IBAction func resetTracking() {
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

}


extension ViewController: ARSessionDelegate{
    
    // 一旦开启合作功能，将定期调用此函数
    // 获取各玩家的现实环境信息，以便所有人能看到同样的虚拟物体--data参数，CollaborationData类型
    func session(_ session: ARSession, didOutputCollaborationData data: ARSession.CollaborationData) {
        guard let multipeerSession = multipeerSession else { return }
        if !multipeerSession.connectedPeers.isEmpty {
            //数据需网络传输，故首先得编码
            //因CollaborationData未遵循Codable协议，遵循的是旧的NSCoding协议，故需用旧方法
            //此方法在“SwiftUI一网打尽”教程中有讲解
            guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
                else { fatalError("collaboration data编码失败") }
            // 因MultipeerConnectivity通信协议发送数据时需指定数据是否可靠，可通过ARKit提供的priority属性进行联动
            let dataIsCritical = data.priority == .critical
            multipeerSession.sendToAllPeers(encodedData, reliably: dataIsCritical)
        } else {
            print("暂未找到新玩家，ARKit之后会再次尝试")
        }
    }
    
    //2-collaboration开启后会形成ARParticipantAnchor以提供自己的世界位置+玩家们合并世界地图成功后可放置立方体模型
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        
        for anchor in anchors {
            if let participantAnchor = anchor as? ARParticipantAnchor {
                messageLabel.displayMessage("和别的玩家联机成功", duration: 6.0)
                
                //将虚拟物体(彩色坐标球体)放置在别的玩家iPhone的位置上以显示别的玩家--实时更新位置和方向
                let position = SIMD3<Float>(
                    participantAnchor.transform.columns.3.x,
                    participantAnchor.transform.columns.3.y,
                    participantAnchor.transform.columns.3.z
                )
                let anchorEntity = AnchorEntity(world: position)
                
                let coordinateSystem = MeshResource.generateCoordinateSystemAxes()
                anchorEntity.addChild(coordinateSystem)
                
                let color = participantAnchor.sessionIdentifier?.toRandomColor() ?? .white
                let coloredSphere = ModelEntity(
                    mesh: MeshResource.generateSphere(radius: 0.03),
                    materials: [SimpleMaterial(color: color, isMetallic: true)]
                )
                anchorEntity.addChild(coloredSphere)
                
                arView.scene.addAnchor(anchorEntity)
                
            } else if anchor.name == "Anchor for object placement" {
                
                //当成功合并两个玩家的世界数据后，其中一玩家点击屏幕添加虚拟立方体的同时，立方体也同时加进了另一个玩家的现实环境中了
                let position = SIMD3<Float>(
                    anchor.transform.columns.3.x,
                    anchor.transform.columns.3.y,
                    anchor.transform.columns.3.z
                )
                let anchorEntity = AnchorEntity(world: position)
                
                let boxLength: Float = 0.05
                let color = anchor.sessionIdentifier?.toRandomColor() ?? .white
                let coloredCube = ModelEntity(
                    mesh: MeshResource.generateBox(size: boxLength),
                    materials: [SimpleMaterial(color: color, isMetallic: true)]
                )
                coloredCube.position = [0, boxLength / 2, 0]
                
                // 放入立方体模型
                anchorEntity.addChild(coloredCube)
                arView.scene.addAnchor(anchorEntity)
            }
        }
    }
    
    
    //错误处理
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "AR Session执行失败", message: errorMessage, preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "重启Session", style: .default) { _ in
                alertController.dismiss(animated: true, completion: nil)
                self.resetTracking()
            }
            alertController.addAction(restartAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


extension ViewController{
    
    //是否发现新玩家(只要人数低于5都算发现)
    func peerDiscovered(_ peer: MCPeerID) -> Bool {
        guard let multipeerSession = multipeerSession else { return false }
        
        if multipeerSession.connectedPeers.count > 3 {
            // 最多四人联机
            messageLabel.displayMessage("第五个人希望加入，但此程序最多四人联机", duration: 6.0)
            return false
        } else {
            return true
        }
    }
    
    private func removeAllAnchorsOriginatingFromARSessionWithID(_ identifier: String) {
        guard let frame = arView.session.currentFrame else { return }
        for anchor in frame.anchors {
            guard let anchorSessionID = anchor.sessionIdentifier else { continue }
            if anchorSessionID.uuidString == identifier {
                arView.session.remove(anchor: anchor)
            }
        }
    }
    
    private func sendARSessionIDTo(peers: [MCPeerID]) {
        guard let multipeerSession = multipeerSession else { return }
        let idString = arView.session.identifier.uuidString
        let command = "SessionID:" + idString
        if let commandData = command.data(using: .utf8) {
            multipeerSession.sendToPeers(commandData, reliably: true, peers: peers)
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    override var prefersHomeIndicatorAutoHidden: Bool { return true }
}
