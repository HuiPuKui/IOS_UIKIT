//
//  ContestViewController.swift
//  ImageSimilarityGame
//
//  Created by 惠蒲葵 on 2025/9/21.
//

import UIKit
import VisionKit

class ContestViewController: UIViewController {

    @IBOutlet weak var originalImageView: UIImageView!
    @IBOutlet weak var scanOriginalImageButton: UIButton!
    @IBOutlet weak var scanContestantImagesButton: UIButton!
    @IBOutlet weak var countdownControllerContainerView: UIView!
    
    let showResultsSegueID = "ShowResultsSegue"
    let embedCountdownSegue = "EmbedCountdownSegue"
    
    enum ScanMode {
        case originalImage
        case contestantImages
    }
    
    var scanMode = ScanMode.originalImage
    var originalImageURL: URL? {
        didSet {
            var newImage: UIImage?
            if let url = originalImageURL {
                newImage = UIImage(contentsOfFile: url.path)
            }
            originalImageView.image = newImage
        }
    }
    var contestantImageURLs = [URL]()
    var countdownController: CountdownViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        UserDefaults.standard.register(defaults: [kSettingsContestDurationKey: 30])
        
        self.originalImageView.alpha = 0
        self.scanContestantImagesButton.alpha = 0
        self.countdownControllerContainerView.alpha = 0
    }
    
    deinit {
        removeSavedImages()
    }

    @IBAction func cancel(_ sender: Any) {
        countdownController?.stop()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func startNewScan(_ sender: UIButton) {
        switch sender {
        case scanOriginalImageButton:
            scanMode = .originalImage
        case scanContestantImagesButton:
            scanMode = .contestantImages
        default:
            break
        }
        
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        present(documentCameraViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case showResultsSegueID:
            guard let resultsViewController = segue.destination as? ResultsViewController else {
                return
            }
            resultsViewController.originalImageURL = self.originalImageURL
            resultsViewController.contestantImageURLs = self.contestantImageURLs
        case embedCountdownSegue:
            countdownController = segue.destination as? CountdownViewController
        default:
            break
        }
    }
    
}

extension ContestViewController: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        switch scanMode {
        case .originalImage:
            originalImageURL = saveImage(scan.imageOfPage(at: 0))
        case .contestantImages:
            for pageIdx in 0 ..< scan.pageCount {
                if let url = saveImage(scan.imageOfPage(at: pageIdx)) {
                    contestantImageURLs.append(url)
                }
            }
        }
        
        controller.dismiss(animated: true) {
            switch self.scanMode {
            case .originalImage:
                // 显示原画 + 隐藏 ‘扫描原画’ 按钮
                UIView.animate(withDuration: 0.25) {
                    self.originalImageView.alpha = 1
                    self.scanOriginalImageButton.alpha = 0
                }
                
                // 根据时间设置或时间流逝，显示‘扫描学生临摹作品’按钮，隐藏相关 view
                let revealContestantImagesScan = {
                    UIView.animate(withDuration: 0.25) {
                        self.scanContestantImagesButton.alpha = 1
                        self.countdownControllerContainerView.alpha = 0
                    }
                }
                let countdownDuration = UserDefaults.standard.integer(forKey: kSettingsContestDurationKey)
                
                if countdownDuration > 0 {
                    self.countdownController?.duration = countdownDuration
                    self.countdownController?.completion = revealContestantImagesScan
                    UIView.animate(withDuration: 0.25) {
                        self.countdownControllerContainerView.alpha = 1
                    }
                } else {
                    revealContestantImagesScan()
                }
                
            case .contestantImages:
                self.performSegue(withIdentifier: self.showResultsSegueID, sender: self)
            }
        }
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

// MARK: - Utility methods
extension ContestViewController {
    
    private func saveImage(_ image: UIImage) -> URL? {
        guard let imageData = image.pngData() else {
            return nil
        }
        
        let baseURL = FileManager.default.temporaryDirectory
        let imageURL = baseURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
        
        do {
            try imageData.write(to: imageURL)
            return imageURL
        } catch {
            print("保存图片到\(imageURL.path)失败，原因是: \(error)")
            return nil
        }
    }
    
    private func removeSavedImages() {
        var urls = contestantImageURLs
        if let originalURL = originalImageURL {
            urls.append(originalURL)
        }
        
        let fileMgr = FileManager.default
        for url in urls {
            try? fileMgr.removeItem(at: url)
        }
    }
    
}
