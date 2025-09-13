//
//  ViewController.swift
//  ML
//
//  Created by 惠蒲葵 on 2025/9/8.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
            self.navigationItem.title = "识别中..."
            
            guard let ciImage = CIImage(image: image) else {
                fatalError("不能把 UIImage 转化为 CIImage")
            }
            
            guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: MLModelConfiguration()).model) else {
                fatalError("加载 MLModel 失败")
            }
            
            let request = VNCoreMLRequest(model: model) { request, error in
                guard let res = request.results else {
                    self.navigationItem.title = "图像识别失败"
                    return
                }
                
                let classification = res as! [VNClassificationObservation]
                if classification.isEmpty {
                    self.navigationItem.title = "不知道是什么"
                } else {
                    self.navigationItem.title = classification.first!.identifier
                }
            }
            
            request.imageCropAndScaleOption = .centerCrop
            
            do {
                try VNImageRequestHandler(ciImage: ciImage).perform([request])
            } catch {
                print("执行图片识别请求失败，原因是: \(error.localizedDescription)")
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController: UINavigationControllerDelegate {
    
    
    
}
