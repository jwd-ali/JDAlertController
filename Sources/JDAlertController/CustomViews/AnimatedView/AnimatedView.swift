//
//  AnimatedView.swift
//  DialogueView
//
//  Created by Jawad Ali on 06/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit
public protocol AnimateLogo {
    var logoLayer: CAShapeLayer { get }
    func animateLayer(duration: Double, delay: Double, completion: AnimationCompletion)
}

@IBDesignable
public class AnimatedView: UIView {

    private var animateLogo: AnimateLogo

    @IBInspectable public var animatioColor: UIColor = .red {
        didSet {
            outMostView.fillColor = animatioColor.withAlphaComponent(0.2).cgColor
            middleView.fillColor = animatioColor.withAlphaComponent(0.4).cgColor
            topMostView.fillColor = animatioColor.cgColor
        }
    }

    @IBInspectable public var lineWidth: CGFloat = 10.0 {
         didSet {
            animateLogo.logoLayer.lineWidth = lineWidth
        }
    }
    @IBInspectable public var strokeColor: UIColor = .white {
        didSet {
            animateLogo.logoLayer.strokeColor = strokeColor.cgColor
        }
    }

   private lazy var viewCenter = CGPoint(x: bounds.midX, y: bounds.midY)
    private lazy var outMostView: CAShapeLayer = {
       let view = CAShapeLayer()
        view.fillColor = animatioColor.withAlphaComponent(0.2).cgColor
       return view
    }()

    private lazy var middleView: CAShapeLayer = {
       let view = CAShapeLayer()
        view.fillColor = animatioColor.withAlphaComponent(0.4).cgColor
       return view
    }()

    private lazy var topMostView: CAShapeLayer = {
        let view = CAShapeLayer()
        view.fillColor = animatioColor.cgColor
        return view
    }()

    public init(logoLayer: AnimateLogo, color: UIColor) {
        animatioColor = color
        animateLogo = logoLayer
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        updatePaths()
        setupView()

        animateLogo.logoLayer.lineWidth = lineWidth
        animateLogo.logoLayer.strokeColor = strokeColor.cgColor
    }

    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
      viewCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        updatePaths()

    }

}
private extension AnimatedView {
    func setupView() {
        layer.addSublayer(outMostView)
        layer.addSublayer(middleView)
        layer.addSublayer(topMostView)

         // animateLogo.wholeLayer.frame = bounds
        layer.addSublayer(animateLogo.logoLayer)
    }
    func updatePaths() {
        animateLogo.logoLayer.frame = bounds
        let path = UIBezierPath(arcCenter: viewCenter, radius: 1, startAngle: 0, endAngle: 360.degreesToRadians, clockwise: true).cgPath

        outMostView.path = path
        middleView.path = path
        topMostView.path = path

    }
}

public extension AnimatedView {

    func startAnimation(completion: AnimationCompletion) {
        let radius = min(bounds.maxX, bounds.maxY)/2

        let outMostViewPath = UIBezierPath(arcCenter: viewCenter,
                                           radius: radius,
                                           startAngle: 0,
                                           endAngle: 360.degreesToRadians,
                                           clockwise: true).cgPath

        let middleViewPath = UIBezierPath(arcCenter: viewCenter,
                                          radius: radius*0.8,
                                          startAngle: 0,
                                          endAngle: 360.degreesToRadians,
                                          clockwise: true).cgPath

        let topViewPath = UIBezierPath(arcCenter: viewCenter,
                                       radius: radius*0.6,
                                       startAngle: 0,
                                       endAngle: 360.degreesToRadians,
                                       clockwise: true).cgPath

        outMostView.animateShape(path: outMostViewPath, duration: 0.6, delay: 0)
        middleView.animateShape(path: middleViewPath, duration: 0.5, delay: 0.2)
        topMostView.animateShape(path: topViewPath, duration: 0.4, delay: 0.3)

        animateLogo.animateLayer(duration: 0.6, delay: 0.6, completion: completion)

    }

}
