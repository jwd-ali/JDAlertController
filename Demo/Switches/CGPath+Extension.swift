//
//  CGPath+Extension.swift
//  Switches
//
//  Created by Jawad Ali on 06/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit
public extension CGRect {
    func drawCheckmarkPath()-> CGPath {
        let bezierPath = UIBezierPath()
        
        let radius = self.maxX/5
        let center = CGPoint(x:self.midX,y:self.midY )
        
        let  x1 = center.x  + (radius ) *  cos(-45.degreesToRadians)
        let  y1 = center.y  + (radius  ) *  sin(-45.degreesToRadians)
        
        let  x2 = center.x  + (radius ) * cos(135.degreesToRadians)
        let  y2 = center.y  + (radius ) * sin(135.degreesToRadians)
        
        bezierPath.move(to: CGPoint(x: x1, y: y1))
        bezierPath.addLine(to: CGPoint(x: x2, y: y2))
        
        let  x3 = center.x  + (radius + radius * 0.5 ) *  cos(-175.degreesToRadians)
        let  y3 = center.y  + (radius  + radius * 0.5  ) *  sin(-175.degreesToRadians)
        
        bezierPath.move(to: CGPoint(x: x3, y: y3))
        bezierPath.addLine(to: CGPoint(x: x2, y: y2 ))
        
        return bezierPath.cgPath
    }
    
    func drawCrossPath()-> CGPath {
        let bezierPath = UIBezierPath()
        
        let radius = self.maxX/5
        let center = CGPoint(x:self.midX,y:self.midY )
        
        let  x1 = center.x  + (radius ) *  cos(-45.degreesToRadians)
        let  y1 = center.y  + (radius  ) *  sin(-45.degreesToRadians)
        
        
        let  x2 = center.x  + (radius ) * cos(135.degreesToRadians)
        let  y2 = center.y  + (radius ) * sin(135.degreesToRadians)
        
        
        let  x3 = center.x  + (radius ) * cos(-135.degreesToRadians)
        let  y3 = center.y  + (radius ) * sin(-135.degreesToRadians)
        
        let  x4 = center.x  + (radius ) * cos(45.degreesToRadians)
        let  y4 = center.y  + (radius ) * sin(45.degreesToRadians)
        
        bezierPath.move(to: CGPoint(x: x4, y: y4))
        bezierPath.addLine(to: CGPoint(x: x3, y: y3))
        
        bezierPath.move(to: CGPoint(x: x1, y: y1))
        bezierPath.addLine(to: CGPoint(x: x2, y: y2))
        
        
        return bezierPath.cgPath
    }
}
