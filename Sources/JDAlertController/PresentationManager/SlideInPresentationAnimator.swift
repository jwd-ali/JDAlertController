//
//  SlideInPresentationAnimator.swift
//  DropDown
//
//  Created by Jawad Ali on 27/11/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
final class SlideInPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresentation: Bool
    let slide: Slide
    init(isPresentation: Bool, slide: Slide) {
        self.isPresentation = isPresentation
        self.slide = slide
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        guard  let controller = transitionContext.viewController(forKey: key) else {return}
        let animationDuration = transitionDuration(using: transitionContext)

        controller.view.translatesAutoresizingMaskIntoConstraints = false
        transitionContext.containerView.addSubview(controller.view)

        controller.view
            .centerHorizontallyInSuperview()
            .width(constant: controller.preferredContentSize.width)

        if slide.side == .top {
            controller.view
                .alignEdgeWithSuperview(.top, constant: CGFloat(slide.offset), priority: .defaultLow)
        } else {
            controller.view
                .alignEdgeWithSuperview(.bottom, constant: CGFloat(slide.offset), priority: .defaultLow)
        }

        transitionContext.containerView.layoutIfNeeded()

        let animationDistance = controller.view.frame.height + CGFloat(slide.offset) + 20

        controller.view.transform = slide.side == .top ?
            (isPresentation ? CGAffineTransform(translationX: 0, y: -animationDistance) :
                .identity) :
            (isPresentation ? CGAffineTransform(translationX: 0, y: animationDistance) :
                .identity)

        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [.beginFromCurrentState,
                                 .curveLinear,
                                 .allowUserInteraction],
                       animations: { [unowned self] in
                        controller.view.transform = self.slide.side == .top ?
                            (self.isPresentation ? .identity : CGAffineTransform(translationX: 0, y: -animationDistance)) :
                            (self.isPresentation ? .identity :
                                CGAffineTransform(translationX: 0, y: animationDistance))
                       }, completion: { completed in
                        transitionContext.completeTransition(completed)
                       })
    }
}
