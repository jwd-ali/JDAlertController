//
//  ErrorAnimationLayer.swift
//  DialogueView
//
//  Created by Jawad Ali on 07/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//


import UIKit
public class ErrorAnimationLayer: CAShapeLayer, AnimateLogo {
    
    
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
        view.fillColor = UIColor.clear.cgColor
        view.backgroundColor = UIColor.clear.cgColor
        view.strokeColor = UIColor.purple.cgColor
        view.lineWidth = lineWidth
        view.lineCap = .round
        return view
    }()
    
    private lazy var crossLayerB: CAShapeLayer = {
        let view = CAShapeLayer()
        view.fillColor = UIColor.clear.cgColor
        view.backgroundColor = UIColor.clear.cgColor
        view.strokeColor = UIColor.purple.cgColor
        view.lineWidth = lineWidth
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
        addSublayer(crossLayerB)
        
        crossLayerA.frame = bounds
        crossLayerB.frame = bounds
        
        crossLayerB.path = linePath()
        crossLayerA.path = linePath()
    }
    
    private func linePath()-> CGPath {
        let viewCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath()
        path.move(to: viewCenter)
        path.addLine(to: viewCenter)
        return path.cgPath
    }
    
}
public extension ErrorAnimationLayer {
    func animateLayer(duration: Double, delay: Double, completion: animationCompletion){
        let path = UIBezierPath()
        let minimumRadius = bounds.midX - bounds.maxX/6
        let maximumRadius = bounds.midX + bounds.maxX/6
        
        path.move(to: CGPoint(x: minimumRadius, y: bounds.midY))
        path.addLine(to: CGPoint(x: maximumRadius, y: bounds.midY))
        
        crossLayerB.animateShape(path: path.cgPath, duration: duration, delay: delay)
        crossLayerA.animateShape(path: path.cgPath, duration: duration, delay: delay)
        
        crossLayerB.rotateAnimationFrames(angels: [0,-165.degreesToRadians,-135.degreesToRadians], times: [0,0.7,1], duration: duration, delay: duration+delay,completion: nil)
        
        crossLayerA.rotateAnimationFrames(angels: [0,-75.degreesToRadians,-45.degreesToRadians], times: [0,0.7,1], duration: duration, delay: duration+delay,completion: completion)
    }
}
