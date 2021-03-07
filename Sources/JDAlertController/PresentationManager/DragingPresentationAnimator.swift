//
//  DragingPresentationAnimator.swift
//  DialogueView
//
//  Created by Jawad Ali on 21/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import Foundation
import UIKit
final class DragingPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    //MARK:- properties
    let isPresentation: Bool
    
    //MARK: - Animator
      var animator = UIDynamicAnimator()
      var attachmentBehavior : UIAttachmentBehavior!
      var gravityBehaviour : UIGravityBehavior!
      var snapBehavior : UISnapBehavior!
    
    //MARK:- initializer
    init(isPresentation: Bool) {
        self.isPresentation = isPresentation
        super.init()
    }
    
    private var areaCenter: CGPoint {
        return CGPoint(x:UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!
          let animationDuration = transitionDuration(using: transitionContext)
        
        
       
       
        if isPresentation {
            controller.view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            controller.view.alpha = 0.1
            transitionContext.containerView.addSubview(controller.view)
            
            controller.view.center = CGPoint( x: areaCenter.x, y: areaCenter.y*0.2 )
            
          //  DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
            UIView.animate(withDuration:animationDuration){
                 controller.view.alpha = 1
            }
                
            
             UIView.animate(withDuration:animationDuration , animations: {
                
                controller.view.translatesAutoresizingMaskIntoConstraints = false
                controller.view
                    .centerInSuperView()
                    .width(constant: controller.preferredContentSize.width)
                
                self.snapBehavior = UISnapBehavior(item: controller.view, snapTo: self.areaCenter)
                self.animator.addBehavior(self.snapBehavior)
                controller.view.transform = .identity
               
                   
                }) { (finished) in
                    transitionContext.completeTransition(true)
                }
          //  }
        } else {
            UIView.animate(
                withDuration: animationDuration/2,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
               
                animations: {
                    self.gravityBehaviour = UIGravityBehavior(items: [controller.view])
                    self.gravityBehaviour.gravityDirection = CGVector.init(dx: 0, dy: 10)
                    controller.view.alpha = 0.6
                    self.animator.addBehavior(self.gravityBehaviour)
                    
//                      controller.view.alpha = 0
//                    self.snapBehavior = UISnapBehavior(item: controller.view, snapTo: CGPoint( x: self.areaCenter.x, y: self.areaCenter.y*2 ))
//                    self.animator.addBehavior(self.snapBehavior)
//                    controller.view.transform = .init(rotationAngle: CGFloat(self.rad2deg(60)))
                    
                    
            }, completion: { finished in
                 transitionContext.completeTransition(finished)
            })
        }
    }
}
extension DragingPresentationAnimator {
func rad2deg(_ number: Double) -> Double {
    return number * 180 / .pi
}
}
