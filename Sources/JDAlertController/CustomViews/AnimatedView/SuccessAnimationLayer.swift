//
//  SuccessAnimation.swift
//  DialogueView
//
//  Created by Jawad Ali on 07/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit
public class SuccessAnimationLayer: CAShapeLayer, AnimateLogo {

   public func animateLayer(duration: Double, delay: Double, completion: AnimationCompletion) {
        logoLayer.strokeAnimation(duration: duration, delay: delay, completion: completion)
    }

    public var logoLayer: CAShapeLayer {
        return self
    }

    public override var frame: CGRect {
        didSet {
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
        strokeEnd = 0
        lineCap = .round

        let viewCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let minimum = min(bounds.midX, bounds.midY)
        path = CGRect(origin: viewCenter, size: CGSize(width: minimum, height: minimum)).drawCheckmarkPath()
    }
}
