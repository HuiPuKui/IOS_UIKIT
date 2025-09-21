/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The custom view that displays progress in the window toolbar and contains the cancel button.
*/

import Cocoa

class ProgressView: NSView {
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var closeButton: NSButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTrackingArea(NSTrackingArea(rect: NSRect(origin: bounds.origin, size: bounds.size),
                                       options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeInKeyWindow],
                                       owner: self,
                                       userInfo: nil))
    }
    
    func updateContents(running flag: Bool) {
        closeButton.isHidden = (!mouseIsInside || !flag)
        progressIndicator.isHidden = (mouseIsInside || !flag)
    }
    
    var mouseIsInside: Bool = false {
        didSet { updateContents(running: isRunning) }
    }
    
    var isRunning: Bool = false {
        didSet {
            if isRunning {
                progressIndicator.startAnimation(nil)
            } else {
                progressIndicator.stopAnimation(nil)
            }
            updateContents(running: isRunning)
        }
    }
    
    override func mouseEntered(with event: NSEvent) { mouseIsInside = true }
    override func mouseExited(with event: NSEvent) { mouseIsInside = false }
}
