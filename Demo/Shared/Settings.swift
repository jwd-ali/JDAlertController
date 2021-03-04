//
//  Settings.swift
//  Demo
//
//  Created by Jawad Ali on 04/03/2021.
//

import JDAlertController
class Settings {
   static let shared = Settings()
    var isDragEnabled: Bool = false
    var preferedStyle: PopupStyle = .alert
    var offSet: Double = 0
    var dismissOuside: Bool = true
    
    private init(){}
}
