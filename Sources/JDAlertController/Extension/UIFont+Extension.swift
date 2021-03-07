//
//  UIFont+Extension.swift
//  VowpayCore
//
//  Created by Zain on 07/08/2020.
//  Copyright © 2020 Vowpay. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    static var titleSmall: UIFont { .systemFont(ofSize: 16, weight: .semibold) }
    static var titleLarge: UIFont { .systemFont(ofSize: 36, weight: .bold) }

    static var highlighted: UIFont { .systemFont(ofSize: 24, weight: .medium) }
    static var subtitle: UIFont { .systemFont(ofSize: 20, weight: .semibold) }

    static var bodyRegular: UIFont { .systemFont(ofSize: 16, weight: .regular) }
    static var bodyMedium: UIFont { .systemFont(ofSize: 16, weight: .medium) }
    static var bodySemibold: UIFont { .systemFont(ofSize: 16, weight: .semibold) }
    static var bodyBold: UIFont { .systemFont(ofSize: 16, weight: .bold) }

    static var buttonText: UIFont { .systemFont(ofSize: 16, weight: .medium) }
    static var headline: UIFont { .systemFont(ofSize: 14, weight: .medium) }

    static var captionLarge: UIFont { .systemFont(ofSize: 12, weight: .medium) }
    static var captionSmall: UIFont { .systemFont(ofSize: 11, weight: .medium) }

    static var tabBar: UIFont { .systemFont(ofSize: 10, weight: .medium) }

    static var initialFont: UIFont {. systemFont(ofSize: 50, weight: .medium)}
}
