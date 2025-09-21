//
//  ResultsViewController.swift
//  ImageSimilarityGame
//
//  Created by 惠蒲葵 on 2025/9/21.
//

import UIKit
import Vision

class ResultsViewController: UIViewController {

    @IBOutlet weak var firstPlaceImageView: UIImageView!
    @IBOutlet weak var firstPlaceLabel: UILabel!
    @IBOutlet weak var secondPlaceImageView: UIImageView!
    @IBOutlet weak var secondPlaceLabel: UILabel!
    @IBOutlet weak var thirdPlaceImageView: UIImageView!
    @IBOutlet weak var thirdPlaceLabel: UILabel!
    
    let showDetailsSegueID = "ShowDetailsSegue"
    
    var originalImageURL: URL?
    var contestantImageURLs = [URL]()

    var ranking = [(contestantIndex: Int, featureprintDistance: Float)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        for label in [firstPlaceLabel, secondPlaceLabel, thirdPlaceLabel] {
            label?.text = ""
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.processImages()
        }
    }
    
    func processImages() {
        guard let originalURL = originalImageURL else { return }
        guard let originalFPO = featureprintObservationForImage(atURL: originalURL) else { return }
        
        for idx in contestantImageURLs.indices {
            let contestantURL = contestantImageURLs[idx]
            guard let contestantFPO = featureprintObservationForImage(atURL: contestantURL) else { return }
            var distance: Float = 0
            do{
                try contestantFPO.computeDistance(&distance, to: originalFPO)
                ranking.append((contestantIndex: idx, featureprintDistance: distance))
            }catch{
                print("计算各个featureprint之间的distance值失败：\(error)")
            }
        }
        
        ranking.sort { res1, res2 in
            return res1.featureprintDistance < res2.featureprintDistance
        }
        
        DispatchQueue.main.async {
            self.presentResults()
        }
    }
    
    // 返回的是特征向量
    func featureprintObservationForImage(atURL url: URL) -> VNFeaturePrintObservation? {
        let handler = VNImageRequestHandler(url: url)
        let request = VNGenerateImageFeaturePrintRequest()
        
        do {
            try handler.perform([request])
            return request.results?.first as? VNFeaturePrintObservation
        } catch {
            print("处理器执行GenerateImageFeaturePrintRequest请求时失败：\(error)")
            return nil
        }
    }
    
    func presentResults() {
        let viewPairs: [(imageView: UIImageView, label: UILabel)] = [
            (firstPlaceImageView, firstPlaceLabel),
            (secondPlaceImageView, secondPlaceLabel),
            (thirdPlaceImageView, thirdPlaceLabel)
        ]
        
        UIView.animate(withDuration: 0.25) {
            for idx in viewPairs.indices {
                let viewPair = viewPairs[idx]
                guard idx < self.ranking.count else {
                    break
                }
                let result = self.ranking[idx]
                let imageURL = self.contestantImageURLs[result.contestantIndex]
                viewPair.imageView.image = UIImage(contentsOfFile: imageURL.path)
                viewPair.label.text = "第\(result.contestantIndex + 1)位学生的作品"
            }
        }
    }
    
    @IBAction func done(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func returnToResults(_ sender: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == showDetailsSegueID, let detailsVC = segue.destination as? DetailsViewController else {
            return
        }
        
        detailsVC.nodes.append((url: originalImageURL, label: "原画", distance: 0))
        
        for entry in ranking {
            let idx = entry.contestantIndex
            let url = contestantImageURLs[idx]
            detailsVC.nodes.append((url: url, label: "第\(idx + 1)位学生", distance: entry.featureprintDistance))
        }
    }

}
