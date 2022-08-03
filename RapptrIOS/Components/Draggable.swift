//
//  Draggable.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/29/22.
//


import Foundation
import UIKit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: DRAGGER
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class DraggableView: UIImageView, UIGestureRecognizerDelegate {
    
    deinit {
        ConsoleLogger.debug("Cycle ended!")
    }
    
    /////////////////////////////////////////////////////////////////
    //MARK: INIT
    /////////////////////////////////////////////////////////////////
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /////////////////////////////////////////////////////////////////
    //MARK: GESTURES
    /////////////////////////////////////////////////////////////////
    lazy var grPan: UIPanGestureRecognizer = {
        let p = UIPanGestureRecognizer(target: self, action: #selector(self.didInitPan))
        return p
    }()
    
    lazy var grPinch: UIPinchGestureRecognizer = {
        let p = UIPinchGestureRecognizer(target: self, action: #selector(self.didInitPinch))
        return p
    }()
    
    lazy var grRotation: UIRotationGestureRecognizer = {
        let r = UIRotationGestureRecognizer(target: self, action: #selector(self.didInitRotate))
        return r
    }()
    
    lazy var grLongpress: UILongPressGestureRecognizer = {
        let l = UILongPressGestureRecognizer(target: self, action: #selector(self.didInitLongPressed))
        l.minimumPressDuration = 1
        return l
    }()
    
    lazy var grTap: UITapGestureRecognizer = {
        let t = UITapGestureRecognizer(target: self, action: #selector(self.didInitDoubleTapped))
        t.numberOfTapsRequired = 2
        return t
    }()

    func initGestureRecognizers() {
        
        grPinch.delegate = self
        grRotation.delegate = self
        addGestureRecognizer(grPan)
        addGestureRecognizer(grPinch)
        addGestureRecognizer(grRotation)
        addGestureRecognizer(grLongpress)
        addGestureRecognizer(grTap)
    }
    
    func gestureRecognizer(_: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func didInitPan() {
        
        self.superview!.bringSubviewToFront(self)
        
        let translation = grPan.translation(in: self.superview)
        
        //let point = CGPoint(x: self.center.x + translation.x + tx, y: self.center.y + translation.y + ty)
        
        
        if grPan.state == .ended || grPan.state == .cancelled {}
        
        adjustAnchorPointForGestureRecognizer(recognizer: grPan)
        updateTransformWithOffset(translation: translation)
    }
    
    @objc func didInitPinch() {
        self.superview!.bringSubviewToFront(self)
        
        if grPinch.state == .began {
            initScale = scale
        }
        scale = initScale * grPinch.scale
        adjustAnchorPointForGestureRecognizer(recognizer: grPinch)
        updateTransformWithOffset(translation: CGPoint.zero)
    }
    
    var tx:CGFloat = 0.0 // x translation
    var ty:CGFloat = 0.0 // y translation
    var scale:CGFloat = 1.0 // zoom scale
    var theta:CGFloat = 0.0 // rotation angle
    var initScale:CGFloat = 1.0
    var initTheta:CGFloat = 0.0
    
    func deinitVars() {
        tx = 0.0 // x translation
        ty = 0.0 // y translation
        scale = 0.0 // zoom scale
        theta = 0.0 // rotation angle
        initScale = 0.0
        initTheta = 0.0
    }
    
    func setAnchorPoint(anchorPoint: CGPoint, forView myView: UIView) {
         let oldOrigin: CGPoint = myView.frame.origin
         myView.layer.anchorPoint = anchorPoint
         let newOrigin = myView.frame.origin
         let transition = CGPoint(x: newOrigin.x - oldOrigin.x, y: newOrigin.y - oldOrigin.y)
         let myNewCenter = CGPoint(x: myView.center.x - transition.x, y: myView.center.y - transition.y)
         myView.center = myNewCenter
     }

     func updateTransformWithOffset(translation: CGPoint) {
        self.transform = CGAffineTransform(translationX: translation.x + tx, y: translation.y + ty)
        self.transform = self.transform.rotated(by: theta)
        self.transform = self.transform.scaledBy(x: scale, y: scale)
     }

     func adjustAnchorPointForGestureRecognizer(recognizer: UIGestureRecognizer) {
        if (recognizer.state == .began) {
            tx = self.transform.tx
            ty = self.transform.ty
            let locationInView = recognizer.location(in: self)
            let newAnchor = CGPoint(x: (locationInView.x / self.bounds.size.width), y: (locationInView.y / self.bounds.size.height))
            setAnchorPoint(anchorPoint: newAnchor, forView: self)

        }
        
        if recognizer.state == .ended {
            
        }
     }
    
    @objc func didInitRotate() {
        self.superview!.bringSubviewToFront(self)

        if grRotation.state == .began {
            initTheta = theta
        }
        theta = initTheta + grRotation.rotation
        adjustAnchorPointForGestureRecognizer(recognizer: grRotation)
        updateTransformWithOffset(translation: CGPoint.zero)
    }
    
    @objc func didInitLongPressed() {
        ConsoleLogger.debug("long pressed")
    }
    
    @objc func didInitDoubleTapped() {
        ConsoleLogger.debug("double tapped")
    }
    
    
    var treshold: CGFloat = 1.0 {
        didSet {
            if treshold > 1.0 {
                treshold = 1.0
            }
            if treshold < 0.0 {
                treshold = 0.0
            }
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.alphaFromPoint(point: point) > treshold
    }
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // If hidden, don't customize behavior
        guard !isHidden else { return super.hitTest(point, with: event) }
        
        // Determine the delta between the width / height and 44, the iOS HIG minimum tap target size.
        // If a side is already longer than 44, add 10 points of padding to either side of the slider along that axis.
        let minimumSideLength: CGFloat = 15
        let padding: CGFloat = -20
        let dx: CGFloat = min(bounds.width - minimumSideLength, padding)
        let dy: CGFloat = min(bounds.height - minimumSideLength, padding)
        
        // If an increased tappable area is needed, respond appropriately
        let increasedTapAreaNeeded = (dx < 0 || dy < 0)
        let expandedBounds = bounds.insetBy(dx: dx / 2, dy: dy / 2)
        
        if increasedTapAreaNeeded && expandedBounds.contains(point) {
            for subview in subviews.reversed() {
                let convertedPoint = subview.convert(point, from: self)
                if let hitTestView = subview.hitTest(convertedPoint, with: event) {
                    return hitTestView
                }
            }
            return self
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
    
    /////////////////////////////////////////////////////////////////
    //MARK: PRESENTATION
    /////////////////////////////////////////////////////////////////
    func setupViews() {
        self.initGestureRecognizers()
    }
    

    
}


