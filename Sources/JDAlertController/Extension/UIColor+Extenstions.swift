//
//  UIColor+Extenstions.swift
//  VowpayCore
//
//  Created by Zain on 07/08/2020.
//  Copyright © 2020 Vowpay. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    static var primary: UIColor { #colorLiteral(red: 0.3665855527, green: 0.2125249207, blue: 0.9989208579, alpha: 1) }
    static var primaryBlue: UIColor { #colorLiteral(red: 0.368627451, green: 0.2156862745, blue: 1, alpha: 1) }

    static var background: UIColor { #colorLiteral(red: 0.9647058824, green: 0.9725490196, blue: 0.9960784314, alpha: 1) }
    static var border: UIColor { #colorLiteral(red: 0.9098039216, green: 0.9294117647, blue: 0.9921568627, alpha: 1) }
    static var icon: UIColor { #colorLiteral(red: 0.662745098, green: 0.6666666667, blue: 0.8745098039, alpha: 1) }

    static var textDark: UIColor { #colorLiteral(red: 0.137254902, green: 0.1568627451, blue: 0.2666666667, alpha: 1) }
    static var textLight: UIColor { #colorLiteral(red: 0.4862745098, green: 0.4823529412, blue: 0.6941176471, alpha: 1) }

    static var success: UIColor { #colorLiteral(red: 0.2470588235, green: 0.8588235294, blue: 0.4666666667, alpha: 1) }
    static var warning: UIColor { #colorLiteral(red: 1, green: 0.5647058824, blue: 0.2509803922, alpha: 1) }
    static var error: UIColor { #colorLiteral(red: 1, green: 0.2156862745, blue: 0.3568627451, alpha: 1) }

    static var placeHolder: UIColor { #colorLiteral(red: 0.4039215686, green: 0.4078431373, blue: 0.6039215686, alpha: 1) }
    static var borderDark: UIColor { #colorLiteral(red: 0.831372549, green: 0.8549019608, blue: 0.9176470588, alpha: 1) }
}
