//
//  InformationAnimationLayer.swift
//  DialogueView
//
//  Created by Jawad Ali on 07/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit
public class InformationAnimationLayer: CAShapeLayer, AnimateLogo {
    
    
    public override var strokeColor: CGColor? {
        didSet {
            crossLayerA.strokeColor = strokeColor
            crossLayerB.strokeColor = strokeColor
        }
    }
    
    public override var lineWidth: CGFloat {
        didSet {
            crossLayerA.lineWidth = lineWidth
            crossLayerB.lineWidth = lineWidth
        }
    }
    
    public override func removeAllAnimations() {
        super.removeAllAnimations()
        crossLayerA.removeAllAnimations()
        crossLayerB.removeAllAnimations()
    }
    
    private lazy var crossLayerA: CAShapeLayer = {
        let view = CAShapeLayer()
        view.fillColor = UIColor.white.cgColor
        view.backgroundColor = UIColor.clear.cgColor
        view.strokeColor = UIColor.clear.cgColor
        view.lineWidth = 5
        view.lineCap = .round
        return view
    }()
    
    private lazy var crossLayerB: CAShapeLayer = {
        let view = CAShapeLayer()
        view.fillColor = UIColor.white.cgColor
        view.backgroundColor = UIColor.clear.cgColor
        view.strokeColor = UIColor.clear.cgColor
       // view.lineWidth = 5
        view.lineCap = .round
        return view
    }()
    
    public var logoLayer: CAShapeLayer   {
        return self
    }
    
    public override var frame: CGRect {
        didSet{
            commonInit()
        }
    }
    
    public override init() {
        super.init()
        commonInit()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func layoutSublayers() {
        super.layoutSublayers()
        commonInit()
    }
    
    private func commonInit() {
        
        fillColor = UIColor.clear.cgColor
        backgroundColor = UIColor.clear.cgColor
        lineCap = .round
        
        addSublayer(crossLayerA)
        //addSublayer(crossLayerB)
        
        let viewCenter = CGPoint(x: bounds.midX-5, y: bounds.midY-5)
        crossLayerA.frame = CGRect(origin: viewCenter, size: CGSize(width: 10, height: 10))
      //  crossLayerB.frame = .zero
        
       // crossLayerB.path = linePath()
        crossLayerA.path = linePath(layerBounds: crossLayerA.frame)
    }
    
    private func linePath(layerBounds: CGRect)-> CGPath {
        
        let radius = layerBounds.size.height/18
        
       let verticalControlOffset = radius
            let horizontalControllOffset = radius / 2
            let height = radius * 5

            let path = UIBezierPath()
            path.addArc(withCenter: CGPoint(x: layerBounds.midX, y: layerBounds.size.height/4 + radius),
                        radius: radius,
                        startAngle: .pi,
                        endAngle: 2 * .pi,
                        clockwise: true)

            var startPoint = path.currentPoint
            var endPoint = CGPoint(x: layerBounds.midX, y: layerBounds.size.height/4 + height)
            var cp1 = CGPoint(x: startPoint.x, y: startPoint.y + verticalControlOffset)
            var cp2 = CGPoint(x: endPoint.x + horizontalControllOffset, y: endPoint.y)

            path.addCurve(to: endPoint,
                          controlPoint1: cp1,
                          controlPoint2: cp2)

            startPoint = path.currentPoint
            endPoint = CGPoint(x: layerBounds.midX - radius, y: layerBounds.size.height/4 + radius)
            cp1 = CGPoint(x: startPoint.x - horizontalControllOffset, y: startPoint.y)
            cp2 = CGPoint(x: endPoint.x, y: endPoint.y + verticalControlOffset)

            path.addCurve(to: endPoint,
                          controlPoint1: cp1,
                          controlPoint2: cp2)

            return path.cgPath
        }
    
    
}
public extension InformationAnimationLayer {
    func animateLayer(duration: Double, delay: Double, completion: animationCompletion) {
//        let path = UIBezierPath()
//        let minimumRadius = bounds.midX - bounds.maxX/6
//        let maximumRadius = bounds.midX + bounds.maxX/6
        
        crossLayerA.boundsAnimationFrames(bounds: [crossLayerA.bounds,bounds], times: [0,1], duration: 4, delay: 0)
        
        

    }
}
