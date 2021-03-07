//
//  UIStackViewFactory.swift
//  MobileExercise
//
//  Created by Jawad Ali on 23/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

public class UIStackViewFactory {
    public class func createStackView(with axis: NSLayoutConstraint.Axis,
                                      alignment: UIStackView.Alignment = .leading,
                                      distribution: UIStackView.Distribution = .fillProportionally,
                                      spacing: CGFloat = 0,
                                      arrangedSubviews: [UIView]? = nil) -> UIStackView {
        let arrangedSubviews = arrangedSubviews ?? []
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
