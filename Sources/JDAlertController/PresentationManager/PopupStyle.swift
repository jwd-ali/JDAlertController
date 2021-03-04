//
//  PopupStyle.swift
//  DialogueView
//
//  Created by Jawad Ali on 14/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit
public enum PopupStyle {
    case alert
    case actionSheet(offset: Double)
    case topSheet(offset: Double)
    case dragIn
}

extension PopupStyle {
    
    var animationControllerPresent: UIViewControllerAnimatedTransitioning {
        switch self {
        case .alert:
            return OpacityPresentationAnimator(isPresentation: true)
        case .actionSheet(let offset):
            return SlideInPresentationAnimator(isPresentation: true, slide: Slide(side: .bottom, offset: offset))
        case .topSheet(let offset):
            return SlideInPresentationAnimator(isPresentation: true, slide: Slide(side: .top, offset: offset))
        case .dragIn:
            return DragingPresentationAnimator(isPresentation: true)
        }
    }
    
    var animationControllerDismiss: UIViewControllerAnimatedTransitioning {
        switch self {
        case .alert:
            return OpacityPresentationAnimator(isPresentation: false)
        case .actionSheet(let offset):
            return SlideInPresentationAnimator(isPresentation: false, slide: Slide(side: .bottom, offset: offset))
        case .topSheet(let offset):
            return SlideInPresentationAnimator(isPresentation: false, slide: Slide(side: .top, offset: offset))
        case .dragIn:
            return DragingPresentationAnimator(isPresentation: false)
        }
    }
    
}

public struct Slide {
    let side: SlideSide
    let offset: Double
}

public enum DisplayStyle {
    case opaccity
    case slide (Slide)
}

public enum SlideSide {
    case bottom
    case top
}
