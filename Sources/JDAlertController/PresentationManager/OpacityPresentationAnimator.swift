//
//  OpacityPresentationAnimator.swift
//  DropDown
//
//  Created by Jawad Ali on 08/01/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit
final class OpacityPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - properties
    let isPresentation: Bool

    // MARK: - initializer
    init(isPresentation: Bool) {
        self.isPresentation = isPresentation
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        guard let controller = transitionContext.viewController(forKey: key) else {return assertionFailure("No Controller")}
        let animationDuration = transitionDuration(using: transitionContext)

        controller.view.translatesAutoresizingMaskIntoConstraints = false
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
            controller.view
                .centerInSuperView()
                .width(constant: controller.preferredContentSize.width)
        }

        let view = controller.view
        view?.alpha =  isPresentation ?  0.25 : view?.alpha ?? 1
        view?.transform = isPresentation ? CGAffineTransform(scaleX: 0.6, y: 0.6) : view?.transform ?? .identity
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            transitionContext.completeTransition(true)
        }
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0,
                       options: [.beginFromCurrentState,
                                 .curveLinear,
                                 .allowUserInteraction],
                       animations: {
                        view?.transform = self.isPresentation ? .identity : CGAffineTransform(scaleX: 0.6, y: 0.6)
                       },
                       completion: nil)
        UIView.animate(withDuration: 0.3 * animationDuration,
                       delay: 0,
                       options: [.beginFromCurrentState,
                                 .curveLinear,
                                 .allowUserInteraction],
                       animations: {
                        view?.alpha = self.isPresentation ? 1 : 0
                       },
                       completion: nil)
        CATransaction.commit()

    }
}
