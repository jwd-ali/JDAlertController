//
//  AViewController.swift
//  SOTabBar_Example
//
//  Created by Jawad Ali on 04/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
          jDNavigationController?.jDnavigationBar?.changeColor(#colorLiteral(red: 0.03393130832, green: 0.7367723253, blue: 0.7563908895, alpha: 1))
       
    }


}
