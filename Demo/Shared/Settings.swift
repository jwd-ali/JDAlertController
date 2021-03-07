//
//  Settings.swift
//  Demo
//
//  Created by Jawad Ali on 04/03/2021.
//
import UIKit
import JDAlertController
class Settings {
   static let shared = Settings()
    var isDragEnabled: Bool = false
    var preferedStyle: PopupStyle = .alert
    var offSet: Double = 0
    var dismissOuside: Bool = true
    var widthRatio: CGFloat  = 0.65
    private init() {}
}
