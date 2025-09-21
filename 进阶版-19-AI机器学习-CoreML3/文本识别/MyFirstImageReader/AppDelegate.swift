/*
See LICENSE folder for this sample’s licensing information.

Abstract:
App delegate.
*/

import Cocoa
import Vision

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, VisionViewDelegate, NSSearchFieldDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var imageView: VisionView!
    @IBOutlet weak var transcriptView: NSTextView!
    @IBOutlet weak var customWordsField: NSTextField!
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var progressView: ProgressView!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.servicesProvider = self
    }
    
    // MARK: Results filtering / highlighting
    @IBAction func highlightResults(_ sender: NSMenuItem) {
        // Flip menu item state
        if sender.state == NSControl.StateValue.on {
            sender.state = NSControl.StateValue.off
        } else {
            sender.state = NSControl.StateValue.on
        }
        imageView.annotationLayer.isHidden = (sender.state == NSControl.StateValue.off)
    }
    
    func controlTextDidChange(_ obj: Notification) {
        // Update the image view.
        imageView.annotationLayer.textFilter = searchField!.stringValue
        
        // Update the transcript.
        let stringRange = transcriptView.string.range(of: searchField!.stringValue)
        if let range = stringRange {
            transcriptView.showFindIndicator(for: NSRange(range, in: transcriptView.string))
        }
    }
    
    // MARK: Request cancellation
    @IBAction func cancelCurrentRequest(_ sender: NSButton) {
        textRecognitionRequest.cancel()
        progressView.isRunning = false
    }
    
    // MARK: Text recognition request options
    var recognitionLevel: VNRequestTextRecognitionLevel = VNRequestTextRecognitionLevel.accurate {
        didSet { performOCRRequest() }
    }
    @IBAction func changeRecognitionLevel(_ sender: NSPopUpButton) {
        guard let selectedItem = sender.selectedItem else {
            return
        }
        switch selectedItem.identifier!.rawValue {
        case "fast":
            recognitionLevel = VNRequestTextRecognitionLevel.fast
        default:
            recognitionLevel = VNRequestTextRecognitionLevel.accurate
        }
    }
    
    var useCPUOnly: Bool = false {
        didSet { performOCRRequest() }
    }
    @IBAction func changeUseCPUOnly(_ sender: NSMenuItem) {
        // Flip menu item state.
        if sender.state == NSControl.StateValue.on {
            sender.state = NSControl.StateValue.off
        } else {
            sender.state = NSControl.StateValue.on
        }
        useCPUOnly = (sender.state == NSControl.StateValue.on)
    }
    
    var useLanguageModel: Bool = true {
        didSet { performOCRRequest() }
    }
    @IBAction func changeUseLanguageModel(_ sender: NSButton) {
        useLanguageModel = (sender.state == NSControl.StateValue.on)
    }
    
    var minTextHeight: Float = 0 {
        didSet { performOCRRequest() }
    }
    @IBAction func changeMinTextHeight(_ sender: NSTextField) {
        minTextHeight = sender.floatValue
    }
    
    var useCustomWords: Bool = false {
        didSet {
            customWordsField!.isEnabled = useCustomWords
            performOCRRequest()
        }
    }
    @IBAction func changeUseCustomWords(_ sender: NSButton) {
        useCustomWords = (sender.state == NSControl.StateValue.on)
    }
    
    var customWords: [String] = [] {
        didSet { performOCRRequest() }
    }
    @IBAction func changeCustomWords(_ sender: NSTextField) {
        let customWordsString = sender.stringValue
        let substrings = customWordsString.split(separator: " ")
        var result: [String] = []
        for substring in substrings {
            result.append(String(substring))
        }
        customWords = result
    }
    
    var results: [VNRecognizedTextObservation]?
    var requestHandler: VNImageRequestHandler?
    var textRecognitionRequest: VNRecognizeTextRequest!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set up UI.
        progressView.isRunning = false
        imageView.delegate = self
        imageView.setupLayers()
        window.makeFirstResponder(imageView)
        
        // Set up the request.
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
    }
    
    func imageDidChange(toImage image: NSImage?) {
        guard let newImage = image else { return }

        if let cgImage = newImage.cgImage(forProposedRect: nil, context: nil, hints: nil) {
            // Set up the request handler.
            requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            
            // Perform the request.
            performOCRRequest()
        } else {
            // Clean up Vision objects
            textRecognitionRequest.cancel()
            requestHandler = nil
            
            // Clean up UI.
            imageView.annotationLayer.results = []
            progressView.isRunning = false
        }
    }
    
    func updateRequestParameters() {
        // Update recognition level.
        switch recognitionLevel {
        case VNRequestTextRecognitionLevel.fast:
            textRecognitionRequest.recognitionLevel = VNRequestTextRecognitionLevel.fast
        default:
            textRecognitionRequest.recognitionLevel = VNRequestTextRecognitionLevel.accurate
        }
        
        // Update minimum text height.
        textRecognitionRequest.minimumTextHeight = self.minTextHeight
        
        // Update language-based correction.
        textRecognitionRequest.usesLanguageCorrection = self.useLanguageModel
        
        // Update custom words, if any.
        if useCustomWords {
            textRecognitionRequest.customWords = customWords
        } else {
            textRecognitionRequest.customWords = []
        }
        
        // Update CPU-only flag.
        textRecognitionRequest.usesCPUOnly = self.useCPUOnly
    }
    
    func performOCRRequest() {
        // Reset the previous request.
        textRecognitionRequest.cancel()
        imageView.annotationLayer.results = []
        
        if imageView.image != nil {
            updateRequestParameters()
            progressView.isRunning = true
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async { [unowned self] in
                do {
                    try self.requestHandler?.perform([self.textRecognitionRequest])
                } catch _ {}
            }
        }
    }
    
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        DispatchQueue.main.async { [unowned self] in
            self.results = self.textRecognitionRequest.results as? [VNRecognizedTextObservation]
            
            // Update progress view.
            self.progressView.isRunning = false
            
            // Update results display in the image view.
            if let results = self.results {
                var displayResults: [((CGPoint, CGPoint, CGPoint, CGPoint), String)] = []
                for observation in results {
                    let candidate: VNRecognizedText = observation.topCandidates(1)[0]
                    let candidateBounds = (observation.bottomLeft, observation.bottomRight, observation.topRight, observation.topLeft)
                    displayResults.append((candidateBounds, candidate.string))
                }
                
                self.imageView.annotationLayer.results = displayResults
            }
            
            // Update transcript view.
            if let results = self.results {
                var transcript: String = ""
                for observation in results {
                    transcript.append(observation.topCandidates(1)[0].string)
                    transcript.append("\n")
                }
                self.transcriptView.string = transcript
            }
        }
    }

}

