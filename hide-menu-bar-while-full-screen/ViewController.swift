//
//  ViewController.swift
//  HelloWorldSwift
//
//  Created by norsasaki_local on 2023/01/01.
//

import Cocoa

extension NSPoint {
    var flipped: NSPoint {
        let screenFrame = (NSScreen.main?.frame)!;
        let screenY = screenFrame.size.height - self.y;
        return NSPoint(x: self.x, y: screenY);
    }
}


public func clamp<T>(_ value: T, minValue: T, maxValue: T) -> T where T : Comparable {
    return min(max(value, minValue), maxValue);
}


class ViewController: NSViewController {

    // Do any additional setup after loading the view.
    private var oldDeltaX: CGFloat = 0;
    private var oldDeltaY: CGFloat = 0;
    private var initialize: Bool = false;
    private var appConfig: NSDictionary!
    private var appList: [String] = [];
    private var widthCut: Float = 0;
    private var heightCut: Float = 0;

    override func viewDidLoad() {
        super.viewDidLoad()

        if(!initialize){
            if let path = Bundle.main.path(forResource: "app", ofType: "plist") {
                self.appConfig = NSDictionary(contentsOfFile: path)
                appList = self.appConfig["TargetApplicaton"] as! [String]
                widthCut = appConfig["WidthCut"] as! Float
                heightCut = appConfig["HeightCut"] as! Float
            }

        }

//        NSEvent.addGlobalMonitorForEvents(matching: [.mouseMoved, .leftMouseDragged, .rightMouseDragged], handler: {(event: NSEvent) in
        NSEvent.addGlobalMonitorForEvents(matching: [.mouseMoved    ], handler: {(event: NSEvent) in
            let frontApp = NSWorkspace.shared.frontmostApplication!.bundleIdentifier as! String
            if( self.appList.contains(frontApp)
                && !event.modifierFlags.contains(.command)
                && !event.modifierFlags.contains(.shift)
                && !event.modifierFlags.contains(.option)
                && !event.modifierFlags.contains(.control)
            ){
                let deltaX = event.deltaX - self.oldDeltaX;
                let deltaY = event.deltaY - self.oldDeltaY;
                
                
                let x = event.locationInWindow.flipped.x;
                let y = event.locationInWindow.flipped.y;

                let window = (NSScreen.main?.frame.size)!;
                let width = CGFloat(window.width - 10);
                let height = CGFloat(window.height - 10);

                let widthCut = (window.width - width) / 2;
                let heightCut = (window.height - height) / 2;

                let xPoint = clamp(x + deltaX, minValue: widthCut, maxValue: window.width - widthCut);
                let yPoint = clamp(y + deltaY, minValue: heightCut, maxValue: window.height - heightCut);
             
                self.oldDeltaX = xPoint - x;
                self.oldDeltaY = yPoint - y;

                //            print("window: \(window)")
                //            print("width: \(width), height: \(height)")
                //            print("oldDeltaX = xPoint - x: \(oldDeltaX) = \(xPoint) - \(x)")
                //            print("oldDeltaY = yPoint - y: \(oldDeltaY) = \(yPoint) - \(y)")
                //            print("flipped.x: \(x), flipped.y: \(y)")
                //            print("widthCut: \(widthCut), heightCut: \(heightCut)")
                //            print("xPoint: \(xPoint), yPoint: \(yPoint)")
                CGWarpMouseCursorPosition(CGPoint(x: xPoint, y: yPoint));

            }
        });
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}


