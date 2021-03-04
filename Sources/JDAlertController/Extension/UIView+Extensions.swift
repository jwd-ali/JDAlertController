//
//  UIView+Extensions.swift
//  VowpayCore
//
//  Created by Zain on 05/08/2020.
//  Copyright © 2020 Vowpay. All rights reserved.
//

import Foundation
import UIKit


// MARK: Inspectables
public extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

//    @IBInspectable
//    var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
    
//    @IBInspectable
//    var borderColor: UIColor? {
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.borderColor = color.cgColor
//            } else {
//                layer.borderColor = nil
//            }
//        }
//    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


// MARK: Redering

public extension UIView {
    
    /// Must be called after layouting
    func roundView() {
        layer.cornerRadius = bounds.width/2
        layer.masksToBounds = true
    }
}

public extension UIView {
    @discardableResult
    func takeScreenshot(rect:CGRect, shouldSave: Bool) -> UIImage? {
        //creates new image context with same size as view
        // UIGraphicsBeginImageContextWithOptions (scale=0.0) for high res capture
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)

        // renders the view's layer into the current graphics context
        if let context = UIGraphicsGetCurrentContext() { layer.render(in: context) }

        // creates UIImage from what was drawn into graphics context
        let screenshot: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        // clean up newly created context and return screenshot
        UIGraphicsEndImageContext()
        
        if let image = screenshot, shouldSave {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
        return screenshot
    }
}
public extension UIView {
    
     func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}
