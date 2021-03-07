//
//  CGPath+Extension.swift
//  Switches
//
//  Created by Jawad Ali on 06/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit
public extension CGRect {
    func drawCheckmarkPath() -> CGPath {
        let bezierPath = UIBezierPath()

        let radius = self.maxX/10
        let center = CGPoint(x: self.midX, y: self.midY )

        let  x11 = center.x - radius*2 + (radius ) *  cos(-45.degreesToRadians)
        let  y11 = center.y - radius*2.3 + (radius  ) *  sin(-45.degreesToRadians)

        let  x21 = center.x - radius*2 + (radius ) * cos(135.degreesToRadians)
        let  y21 = center.y  - radius*2.3 + (radius ) * sin(135.degreesToRadians)

       // bezierPath.move(to: CGPoint(x: x1, y: y1))

        let  x31 = center.x - radius*2 + (radius + radius * 0.5 ) *  cos(-175.degreesToRadians)
        let  y31 = center.y - radius*2.3 + (radius  + radius * 0.5  ) *  sin(-175.degreesToRadians)

        bezierPath.move(to: CGPoint(x: x31, y: y31))
        bezierPath.addLine(to: CGPoint(x: x21, y: y21 ))
         bezierPath.addLine(to: CGPoint(x: x11, y: y11))

        bezierPath.lineJoinStyle = .round

        return bezierPath.cgPath
    }

    func drawCrossPath() -> CGPath {
        let bezierPath = UIBezierPath()

        let radius = self.maxX/5
        let center = CGPoint(x: self.midX, y: self.midY )

        let  x11 = center.x  + (radius ) *  cos(-45.degreesToRadians)
        let  y11 = center.y  + (radius  ) *  sin(-45.degreesToRadians)

        let  x21 = center.x  + (radius ) * cos(135.degreesToRadians)
        let  y21 = center.y  + (radius ) * sin(135.degreesToRadians)

        let  x31 = center.x  + (radius ) * cos(-135.degreesToRadians)
        let  y31 = center.y  + (radius ) * sin(-135.degreesToRadians)

        let  x41 = center.x  + (radius ) * cos(45.degreesToRadians)
        let  y41 = center.y  + (radius ) * sin(45.degreesToRadians)

        bezierPath.move(to: CGPoint(x: x41, y: y41))
        bezierPath.addLine(to: CGPoint(x: x31, y: y31))

        bezierPath.move(to: CGPoint(x: x11, y: y11))
        bezierPath.addLine(to: CGPoint(x: x21, y: y21))

        return bezierPath.cgPath
    }

}
