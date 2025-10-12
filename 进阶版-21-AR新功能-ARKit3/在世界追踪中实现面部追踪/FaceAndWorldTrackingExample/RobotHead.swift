import RealityKit
import ARKit

class RobotHead: Entity, HasModel {
    
    // 默认颜色值
    private let inactiveColor: SimpleMaterial.Color = .gray
    private let eyeColor: SimpleMaterial.Color = .blue
    private let eyebrowColor: SimpleMaterial.Color = .brown
    private let headColor: SimpleMaterial.Color = .green
    private let lipColor: SimpleMaterial.Color = .lightGray
    private let mouthColor: SimpleMaterial.Color = .gray
    private let tongueColor: SimpleMaterial.Color = .red
    private let clearColor: SimpleMaterial.Color = .clear
    private let notTrackedColor: SimpleMaterial.Color = UIColor.lightGray.withAlphaComponent(0.3)
    
    private var originalJawY: Float = 0
    private var originalUpperLipY: Float = 0
    private var originalEyebrowY: Float = 0
    
    private lazy var eyeLeftEntity = findEntity(named: "eyeLeft")!
    private lazy var eyeRightEntity = findEntity(named: "eyeRight")!
    private lazy var eyebrowLeftEntity = findEntity(named: "eyebrowLeft")!
    private lazy var eyebrowRightEntity = findEntity(named: "eyebrowRight")!
    private lazy var jawEntity = findEntity(named: "jaw")!
    private lazy var upperLipEntity = findEntity(named: "upperLip")!
    private lazy var headEntity = findEntity(named: "head")!
    private lazy var tongueEntity = findEntity(named: "tongue")!
    private lazy var mouthEntity = findEntity(named: "mouth")!
    
    private lazy var jawHeight: Float = {
        let bounds = jawEntity.visualBounds(relativeTo: jawEntity)
        return (bounds.max.y - bounds.min.y)
    }()
    
    private lazy var height: Float = {
        let bounds = headEntity.visualBounds(relativeTo: nil)
        return (bounds.max.y - bounds.min.y)
    }()
    
    required init() {
        super.init()
        
        if let robotHead = try? Entity.load(named: "robotHead") {
            addChild(robotHead)
        } else {
            fatalError("加载模型失败")
        }
        
        originalJawY = jawEntity.position.y
        originalUpperLipY = upperLipEntity.position.y
        originalEyebrowY = eyebrowLeftEntity.position.y
    }
    
    // MARK: - Appearance
    
    enum Appearance {
        case tracked
        case notTracked
        case intersecting
        case anchored
    }
    
    var appearance: Appearance = .notTracked {
        didSet {
            // 先全部用默认颜色，根据人脸追踪状态再个别分配颜色
            headEntity.color = headColor
            eyeLeftEntity.color = eyeColor
            eyeRightEntity.color = eyeColor
            eyebrowLeftEntity.color = eyebrowColor
            eyebrowRightEntity.color = eyebrowColor
            upperLipEntity.color = lipColor
            jawEntity.color = lipColor
            mouthEntity.color = mouthColor
            tongueEntity.color = tongueColor
            
            switch appearance {
            case .anchored:
                headEntity.color = inactiveColor //定格色--单头部灰色
            case .intersecting:
                headEntity.color = notTrackedColor //单头部透明灰色
                //在大多数语言的switch块中，case后要加break，才能跳出switch，否则所有的case都会顺序执行
                //Swift中默认每个case执行完直接跳出，无需写break，若想让之后的case继续执行(无论条件是否满足)，则使用fallthrough
                fallthrough
            case .notTracked:
                eyeLeftEntity.color = notTrackedColor
                eyeRightEntity.color = notTrackedColor
                eyebrowLeftEntity.color = notTrackedColor
                eyebrowRightEntity.color = notTrackedColor
                upperLipEntity.color = notTrackedColor
                jawEntity.color = notTrackedColor
                mouthEntity.color = clearColor
                tongueEntity.color = clearColor
            default: break //已追踪到人脸的话就用默认颜色
            }
        }
    }
    
    // MARK: - Animations
    // 更新虚拟头部模型面部表情为追踪到的人脸面部表情
    func update(with faceAnchor: ARFaceAnchor) {
        // 追踪到的人脸表情数据--混合形状blendShapes
        // 取出其字典里的各个value(0.0-1.0)，表示各部位(眨眼，眉毛，嘴巴开合，舌头)的移动量
        let blendShapes = faceAnchor.blendShapes
        guard let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
            let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float,
            let eyeBrowLeft = blendShapes[.browOuterUpLeft] as? Float,
            let eyeBrowRight = blendShapes[.browOuterUpRight] as? Float,
            let jawOpen = blendShapes[.jawOpen] as? Float,
            let upperLip = blendShapes[.mouthUpperUpLeft] as? Float,
            let tongueOut = blendShapes[.tongueOut] as? Float
            else { return }
        
        // 根据blendShapes同步更新虚拟模型的表情(各部位的位置)--因单位为米，需做一些变小处理
        eyebrowLeftEntity.position.y = originalEyebrowY + 0.03 * eyeBrowLeft
        eyebrowRightEntity.position.y = originalEyebrowY + 0.03 * eyeBrowRight
        tongueEntity.position.z = 0.1 * tongueOut
        jawEntity.position.y = originalJawY - jawHeight * jawOpen
        upperLipEntity.position.y = originalUpperLipY + 0.05 * upperLip
        eyeLeftEntity.scale.z = 1 - eyeBlinkLeft
        eyeRightEntity.scale.z = 1 - eyeBlinkRight

        // 镜像效果--更改虚拟头部模型的transform，使我们看到后置相机中的模型时就跟照镜子一样
        guard let parent = parent else { return }

        // 设置虚拟头部模型的位置--它到后置相机的距离=人脸到前置相机的距离
        let cameraTransform = parent.transformMatrix(relativeTo: nil)
        let faceTransformFromCamera = simd_mul(simd_inverse(cameraTransform), faceAnchor.transform)
        self.position.z = -faceTransformFromCamera.columns.3.z

        // 设置虚拟头部模型的方向
        let rotationEulers = faceTransformFromCamera.eulerAngles
        let mirroredRotation = Transform(pitch: rotationEulers.x, yaw: -rotationEulers.y + .pi, roll: rotationEulers.z) // 围绕y轴转180度
        self.orientation = mirroredRotation.rotation
    }
    
    // MARK: - Proximity check to other entities
    // 检查和其他entity的接近程度
    func isTooCloseToAnchoredHeads(in scene: Scene) -> Bool {
        let worldPosition = position(relativeTo: nil)
        
        let anchoredHeads = scene.anchors.filter { $0.isAnchored && $0.anchoring != .init(.camera) }
        let anchoredHeadPositions = anchoredHeads.compactMap { $0.children.first?.position(relativeTo: nil) }
        for anchoredPosition in anchoredHeadPositions {
            if distance(worldPosition, anchoredPosition) < height {
                return true
            }
        }
        return false
    }
}
