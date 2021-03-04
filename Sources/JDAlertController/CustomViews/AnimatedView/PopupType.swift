//
//  PopupType.swift
//  DialogueView
//
//  Created by Jawad Ali on 14/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit
public enum PopupType {
    case success
    case error
}
extension PopupType {
    var color: UIColor {
        switch self {
        case .success:
            return #colorLiteral(red: 0.1944677234, green: 0.861061275, blue: 0.9629308581, alpha: 1)
        case .error:
            return #colorLiteral(red: 0.9998564124, green: 0.4897186756, blue: 0.5090405345, alpha: 1)
        }
    }
    
    var animationLayer: AnimateLogo {
        switch self {
        case .success:
            return SuccessAnimationLayer()
        case .error:
            return ErrorAnimationLayer()
        }
    }
}
