//
//  UIImageViewFactory.swift
//  MobileExercise
//
//  Created by Jawad Ali on 23/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
public class UIImageViewFactory {
    public class func createBackgroundImageView(mode: UIImageView.ContentMode = .scaleAspectFill,
                                                image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = mode
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        return imageView
    }
    public class func createImageView(mode: UIImageView.ContentMode = .scaleAspectFill,
                                      image: UIImage? = nil,
                                      tintColor: UIColor? = .clear) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = mode
        imageView.tintColor = tintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        return imageView
    }
}
