import Cocoa
import CreateML

// 总数据
let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/huipukui/Desktop/AllFile/IOS_UIKIT/IOS_UIKIT/进阶版-18-AI机器学习-CoreML2/SentimentAnalysis/spam.csv"))

// 把数据分为训练数据和测试数据
let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

// 开始训练 -- 并得出情感识别器（sentimentClassifier） - 也是训练出来的 mlmodel
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "label")

let evaluationAccuracy = 1.0 - sentimentClassifier.evaluation(on: testingData,
                                                textColumn: "text",
                                                labelColumn: "label").classificationError

print("准确率: \(evaluationAccuracy)")

// 设置 mlmodel 元数据
let metadata = MLModelMetadata(author: "HuiPuKui", shortDescription: "A model trained to classify spam SMS", version: "1.0")
// 保存 mlmodel
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/huipukui/Desktop/AllFile/IOS_UIKIT/IOS_UIKIT/进阶版-18-AI机器学习-CoreML2/SentimentAnalysis/spam.mlmodel"), metadata: metadata)

// 识别是否是垃圾短信
try sentimentClassifier.prediction(from: "hi, how are you?")
try sentimentClassifier.prediction(from: "Had your mobile 11 mouths or more? U R entitled to Update to the latest colour mobiles with camera for Free! Call The Mobile Update Co FREE on 08002986030")
