//
//  LayoutAttributes.swift
//  MobileExercise
//
//  Created by Jawad Ali on 23/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
import UIKit

enum  LayoutAxis {
    case vertical
    case horizontal
    case dimensions
}

public enum  LayoutEdge {
    case left
    case right
    case top
    case bottom
    case bottomAvoidingKeyboard
    case safeAreaLeft
    case safeAreaRight
    case safeAreaTop
    case safeAreaBottom
    case safeAreaBottomAvoidingKeyboard
    case centerX
    case centerY
    case height
    case width
}

extension  LayoutEdge {
    var axis: LayoutAxis {
        switch self {
        case .left, .right, .centerX, .safeAreaLeft, .safeAreaRight:
            return .horizontal
        case .bottom, .top, .centerY, .safeAreaTop, .safeAreaBottom, .bottomAvoidingKeyboard, .safeAreaBottomAvoidingKeyboard:
            return .vertical
        case .height, .width:
            return .dimensions

        }
    }

    var safeAreaEdge: LayoutEdge {
        switch self {
        case .left, .safeAreaLeft:
            return .safeAreaLeft
        case .top, .safeAreaTop:
            return .safeAreaTop
        case .right, .safeAreaRight:
            return .safeAreaRight
        case .bottom, .safeAreaBottom, .bottomAvoidingKeyboard, .safeAreaBottomAvoidingKeyboard:
            return .safeAreaBottom
        default:
            return .safeAreaLeft
        }
    }
}

public enum  LayoutConstantModifier {
    case equalTo
    case lessThanOrEqualTo
    case greaterThanOrEqualTo
}

internal extension UIView {
    func horizontalAnchor(_ edge: LayoutEdge) -> NSLayoutXAxisAnchor {
        switch edge {
        case .left:
            return leadingAnchor
        case .right:
            return trailingAnchor
        case .centerX:
            return centerXAnchor
        case .safeAreaLeft:
            return safeAreaLayoutGuide.leadingAnchor
        case .safeAreaRight:
            return safeAreaLayoutGuide.trailingAnchor
        default:
            return leadingAnchor
        }
    }

    func verticalAnchor(_ edge: LayoutEdge) -> NSLayoutYAxisAnchor {
        switch edge {
        case .top:
            return topAnchor
        case .bottom, .bottomAvoidingKeyboard:
            return bottomAnchor
        case .centerY:
            return centerYAnchor
        case .safeAreaTop:
            return safeAreaLayoutGuide.topAnchor
        case .safeAreaBottom, .safeAreaBottomAvoidingKeyboard:
            return safeAreaLayoutGuide.bottomAnchor
        default:
            return topAnchor
        }
    }

    func dimensionAnchor(_ edge: LayoutEdge) -> NSLayoutDimension {
        switch edge {
        case .width:
            return widthAnchor
        case .height:
            return heightAnchor
        default:
            return widthAnchor
        }
    }
}
