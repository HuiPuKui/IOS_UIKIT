import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var arView: ARView!
    @IBOutlet weak var messageLabel: MessageLabel!
    @IBOutlet weak var restartButton: UIButton!
    
    let coachingOverlay = ARCoachingOverlayView()
    let configuration = ARWorldTrackingConfiguration()
    
    /// - Tag: HeadPreview
    var headPreview: RobotHead?
    
    enum Instruction: String {
        case freezeFacialExpression = "点击以定格面部表情"
        case noFaceDetected = "未识别到人脸"
        case moveFurtherAway = "离已定格人脸远一点，给新人脸一点空间"
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView.session.delegate = self
        
        // 使用自定义配置
        arView.automaticallyConfigureSession = false
        
        setupCoachingOverlay()

        // 禁用运动时模糊的渲染特效，使模型始终保持清晰
        arView.renderOptions.insert(.disableMotionBlur)
        
        // 环境纹理设为自动(基于图像照明算法，真实地反射周围环境的光线，使虚拟模型更逼真)
        configuration.environmentTexturing = .automatic
        
        // 在世界追踪session中开启人脸追踪，之后会获得ARFaceAnchor
        configuration.userFaceTrackingEnabled = true
        
        // 防止屏幕变暗让体验变差--禁用idle timer避免因屏幕无交互后的系统自动睡眠
        UIApplication.shared.isIdleTimerDisabled = true
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
    }

    /// - Tag: RunConfiguration
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arView.session.run(configuration)
    }
    
    // MARK: - ARSessionDelegate
    
    /// 当前无模型且追踪状态为正常时添加机器人头部模型
    /// - Tag: AddHeadPreview
    // 自定义渲染器(自定义配置)
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        if headPreview == nil, case .normal = frame.camera.trackingState {
            // 创建前置相机anchorEntity以追踪相机位置
            // 注：需要为每一次的头部模型创建一个新camera锚点-因点击屏幕后会更新以前的锚点
            let camera = AnchorEntity(.camera)
            arView.scene.addAnchor(camera)

            let robotHead = RobotHead()
            camera.addChild(robotHead)
            
            // 一开始的时候将头部模型移动到摄像机后面以隐藏，直到第一次追踪用户的脸部为止
            robotHead.position.z = 1.0
            
            headPreview = robotHead
        }
        
        // 若指导view消失了则显示头部模型
        headPreview?.isEnabled = !coachingOverlay.isActive
        
        // 根据追踪状态更新头部模型的外观
        updateHeadPreviewAppearance(for: frame)
    }
    
    /// 获取到ARFaceAnchor后更新虚拟头部模型(包含基本的大小位置方向及FaceTracking特有的面部表情)
    /// - Tag: UpdateFacialExpression
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        anchors.compactMap { $0 as? ARFaceAnchor }.forEach { headPreview?.update(with: $0) }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        displayErrorMessage(for: error)
    }
    
    
    // MARK: - User interaction and messages
    /// - Tag: HandleTap
    @objc
    func handleTap(recognizer: UITapGestureRecognizer) {
        guard let robotHeadPreview = headPreview, robotHeadPreview.isEnabled, robotHeadPreview.appearance == .tracked else { return }
        
        // 保留当前模型在现实环境中的锚点
        let headWorldTransform = robotHeadPreview.transformMatrix(relativeTo: nil)
        robotHeadPreview.anchor?.reanchor(.world(transform: headWorldTransform))
        robotHeadPreview.appearance = .anchored

        // 将headPreview设置为nil，可阻止在session(didUpdate)中继续更新面部表情--定格虚拟头部模型
        self.headPreview = nil
    }
    
    @IBAction func restartButtonPressed(_ sender: Any) {
        resetTracking()
    }
    
    func resetTracking() {
        headPreview = nil
        arView.scene.anchors.removeAll()
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        messageLabel.displayMessage("")
    }
    
    private func updateHeadPreviewAppearance(for frame: ARFrame) {
        
        guard let robotHeadPreview = headPreview else { return }
        
        // 判断当前新的头部模型是否和之前定格的模型有交叉
        if robotHeadPreview.isTooCloseToAnchoredHeads(in: arView.scene) {
            robotHeadPreview.appearance = .intersecting
            showInstruction(.moveFurtherAway)
            return
        }

        let faceAnchors = frame.anchors.compactMap { $0 as? ARFaceAnchor }
        
        // 判断是否已追踪到人脸
        if faceAnchors.first(where: { $0.isTracked }) != nil {
            robotHeadPreview.appearance = .tracked
            showInstruction(.freezeFacialExpression)
        } else {
            robotHeadPreview.appearance = .notTracked
            showInstruction(.noFaceDetected)
        }
    }
    
    private func showInstruction(_ instruction: Instruction) {
        messageLabel.displayMessage(instruction.rawValue, duration: 5)
    }
    
    private func displayErrorMessage(for error: Error) {
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
    

    // MARK: - Overrides
    
    // 隐藏状态栏以提高AR体验的沉浸感
    override var prefersStatusBarHidden: Bool { return true }
    
    // 让全屏幕iPhone下方的黑色条自动隐藏(仅界面无交互时)
    override var prefersHomeIndicatorAutoHidden: Bool { return true }
}
