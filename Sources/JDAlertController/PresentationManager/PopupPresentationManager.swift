//
//  PopupPresentationManager.swift
//  DropDown
//
//  Created by Jawad Ali on 27/11/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
open class PopupPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
    
    //MARK:- properties
    public var type: PopupStyle = .alert
   
    public var presentationController: DimmedPopupPresentationController!
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
         presentationController = DimmedPopupPresentationController(presentedViewController: presented,
                                                                       presenting: presenting)
        
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return type.animationControllerPresent
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return type.animationControllerDismiss
    }
}

