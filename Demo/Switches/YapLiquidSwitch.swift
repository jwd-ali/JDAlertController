//
//  TKLiquidSwitch.swift
//  testi
//
//  Created by Jawad Ali on 13/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

// Dedign by Oleg Frolov
//https://dribbble.com/shots/2028065-Switcher-lll

@IBDesignable
open class YapLiquidSwitch: YapBaseSwitch {

    private var bubbleLayer = CAShapeLayer()
    private var lineLayer   = CAShapeLayer()
    @IBInspectable open var onColor: UIColor = UIColor(red: 0.373, green: 0.843, blue: 0.596, alpha: 1) {
        didSet {
            resetView()
        }
    }

    @IBInspectable open var offColor: UIColor = UIColor(red: 0.871, green: 0.871, blue: 0.871, alpha: 1) {
        didSet {
            resetView()
        }
    }

    override internal func setUpView() {
        super.setUpView()

        self.clipsToBounds = true

        lineLayer.path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                          y: (self.bounds.height - 20 * sizeScale) / 2,
                                                          width: self.bounds.width,
                                                          height: 20 * sizeScale), cornerRadius: 10 * sizeScale).cgPath
        lineLayer.fillColor = switchColor(isOn).cgColor
        self.layer.addSublayer(lineLayer)

        bubbleLayer.frame = self.bounds
        bubbleLayer.position = bubblePosition(isOn)
        bubbleLayer.path = bubbleShapePath
        bubbleLayer.fillColor = switchColor(isOn).cgColor
        self.layer.addSublayer(bubbleLayer)

    }

    override func changeValueAnimate(_ value: Bool, duration: Double) {
        let bubbleTransformAnim      = CAKeyframeAnimation(keyPath: "transform")
        bubbleTransformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity),
                                        NSValue(caTransform3D: CATransform3DMakeScale(1, 0.8, 1)),
                                        NSValue(caTransform3D: CATransform3DMakeScale(0.8, 1, 1)),
                                        NSValue(caTransform3D: CATransform3DIdentity)]
        bubbleTransformAnim.keyTimes = [NSNumber(value: 0), NSNumber(value: 1.0 / 3.0), NSNumber(value: 2.0 / 3.0), NSNumber(value: 1)]
        bubbleTransformAnim.duration = duration

        let bubblePositionAnim = CABasicAnimation(keyPath: "position")
        bubblePositionAnim.fromValue =  NSValue(cgPoint: bubblePosition(!isOn))
        bubblePositionAnim.toValue   = NSValue(cgPoint: bubblePosition(isOn))
        bubblePositionAnim.duration  = duration

        let bubbleGroupAnim = CAAnimationGroup()
        bubbleGroupAnim.animations = [bubbleTransformAnim, bubblePositionAnim]
        bubbleGroupAnim.isRemovedOnCompletion = false
        bubbleGroupAnim.fillMode = CAMediaTimingFillMode.forwards
        bubbleGroupAnim.duration = duration

        bubbleLayer.add(bubbleGroupAnim, forKey: "Bubble")

        let color = switchColor(value).cgColor
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.lineLayer.fillColor = color
            self.bubbleLayer.fillColor = color
        })

    }
}

// Getter
extension YapLiquidSwitch {

    var bubbleSize: CGSize {
        let lineH = 20 * sizeScale
        let width =  lineH * 2 + bounds.height
        let height = bounds.height
        return CGSize(width: width, height: height)
    }

    var bubbleShapePath: CGPath {
            let bubblePath = UIBezierPath()
            let size = bubbleSize
            let ssR = (size.width - size.height)/4
            let llR = size.height/2

            let ll1 = CGPoint(x: ssR, y: llR - ssR)
            let ll2 = CGPoint(x: ssR, y: llR + ssR)

            let cc1 = CGPoint(x: ssR * 2 + llR, y: 0)
            let cc2 = CGPoint(x: ssR * 2 + llR, y: llR * 2)

            let rr1 = CGPoint(x: ssR * 3 + llR * 2, y: llR - ssR)
            let rr2 = CGPoint(x: ssR * 3 + llR * 2, y: llR + ssR)

            let oo1 = CGPoint(x: (llR + ssR * 2)/4, y: llR - ssR)
            let oo2 = CGPoint(x: (llR + ssR * 2)/4, y: llR + ssR)
            let oo3 = CGPoint(x: (llR * 2 + ssR * 4) - (llR + ssR * 2)/4, y: llR - ssR)
            let oo4 = CGPoint(x: (llR * 2 + ssR * 4) - (llR + ssR * 2)/4, y: llR + ssR)

    //        let cL = CGPoint(x: sR, y: lR)
            let ccC = CGPoint(x: ssR * 2 + llR, y: llR)
    //        let cR = CGPoint(x: sR * 3 + lR * 2, y: lR)

            bubblePath.move(to: ll1)
            bubblePath.addQuadCurve(to: cc1, controlPoint: oo1)
            bubblePath.addArc(withCenter: ccC, radius: llR, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi*3/2, clockwise: true)
            bubblePath.addQuadCurve(to: rr1, controlPoint: oo3)
            bubblePath.addLine(to: rr2)

            bubblePath.addQuadCurve(to: cc2, controlPoint: oo4)
            bubblePath.addQuadCurve(to: ll2, controlPoint: oo2)
            bubblePath.addLine(to: ll1)
            bubblePath.close()

            return bubblePath.cgPath
        }

    func switchColor(_ isOn: Bool) -> UIColor {
        if isOn {
            return onColor
        } else {
            return offColor
        }
    }

    func bubblePosition(_ isOn: Bool) -> CGPoint {
        let height = self.bounds.height
        let width = self.bounds.width
        let bbW = bubbleSize.width

        if isOn {
            return CGPoint(x: bbW * 0.8, y: height/2)
        } else {
            return CGPoint(x: width - bbW*0.2, y: height/2)
        }
    }
}
