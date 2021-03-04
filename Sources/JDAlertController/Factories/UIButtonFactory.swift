//
//  UIButtonFactory.swift
//  YAPKit
//
//  Created by Wajahat Hassan on 31/07/2019.
//  Copyright © 2019 YAP. All rights reserved.
//

import UIKit
public class UIButtonFactory {
    
    public class func createButton(title: String = String(), backgroundColor: UIColor = .clear, textColor: UIColor =  .textDark) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

