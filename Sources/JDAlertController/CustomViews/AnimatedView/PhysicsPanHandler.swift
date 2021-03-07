//
//  PhysicsPanHandler.swift
//  DialogueView
//
//  Created by Jawad Ali on 14/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit

open class PhysicsPanHandler {
    // MARK: - Animator
    private let animator: UIDynamicAnimator
    private  var attachmentBehavior: UIAttachmentBehavior!
    private var gravityBehaviour: UIGravityBehavior!
    private var snapBehavior: UISnapBehavior!
    private var restingCenter: CGPoint?
    private var dismisscontroller: AnimationCompletion

    weak var messageView: UIView?
    weak var containerView: UIView?

    private var areaCenter: CGPoint {
          return CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
      }

    public init(messageView: UIView?, containerView: UIView?, dismiss: AnimationCompletion) {
        self.messageView = messageView
        self.containerView = containerView
        self.dismisscontroller = dismiss
        animator = UIDynamicAnimator(referenceView: containerView ?? UIView())
        messageView?.addGestureRecognizer(pan)
    }

    public private(set) lazy var pan: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(pan(_:)))
        return pan
    }()

    public func stop() {
        animator.removeAllBehaviors()
    }
}

extension PhysicsPanHandler {
    // MARK: - Handle Gesture
    @objc func pan(_ sender: UIPanGestureRecognizer) {
          guard let messageView = messageView, let containerView = containerView else { return }
        switch sender.state {
        case  .began:
            restingCenter = messageView.center
            animator.removeAllBehaviors()
            let centerOffset = UIOffset(horizontal: sender.location(in: messageView).x - messageView.bounds.midX,
                                        vertical: sender.location(in: messageView).y - messageView.bounds.midY)
            attachmentBehavior = UIAttachmentBehavior(item: messageView,
                                                      offsetFromCenter: centerOffset, attachedToAnchor: sender.location(in: containerView))
            attachmentBehavior.frequency = 0
            animator.addBehavior(attachmentBehavior)

        case .changed:
            self.attachmentBehavior.anchorPoint = sender.location(in: containerView)

        case .ended, .cancelled:

            let translation = sender.translation(in: messageView)
            let velocity = sender.velocity(in: containerView)
            let speed = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2))

            if speed > 500 || translation.y > 250 {
                 self.animator.removeBehavior(self.attachmentBehavior)
                animator.removeAllBehaviors()
                gravityBehaviour = UIGravityBehavior(items: [messageView])
                gravityBehaviour.gravityDirection = CGVector.init(dx: 0, dy: 10)
                animator.addBehavior(gravityBehaviour)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
                    if let completion = self.dismisscontroller {
                        messageView.alpha = 0
                        self.animator.removeAllBehaviors()
                        completion()
                    }
                }

            } else {
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 0.65,
                               initialSpringVelocity: 0,
                               options: .beginFromCurrentState,
                               animations: {
                               self.attachmentBehavior.anchorPoint = self.restingCenter ?? self.areaCenter
                               self.animator.removeBehavior(self.attachmentBehavior)
                            })
                           self.snapBehavior = UISnapBehavior(item: messageView, snapTo: restingCenter ?? areaCenter)
                           self.animator.addBehavior(snapBehavior)
            }
        default:
            break
        }
    }

}
