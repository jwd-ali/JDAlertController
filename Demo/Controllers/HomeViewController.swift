//
//  HomeViewController.swift
//  Demo
//
//  Created by Jawad Ali on 10/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import JDTabBarController
import JDAlertController
class HomeViewController: UIViewController {

    @IBOutlet weak var offsetField: UITextField!
    @IBOutlet weak var isDragSwitch: SwitcherFullStrtech!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var switcher: Switcher!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        
    }
    @IBAction func offsetChanged(_ sender: UITextField) {
        Settings.shared.offSet = Double(sender.text ?? "") ?? 0
    }
    @IBAction func isDragableOn(_ sender: Switcher) {
        Settings.shared.isDragEnabled = sender.isOn
    }
    @IBAction func touchOutsideAllowed(_ sender: Switcher) {
        Settings.shared.dismissOuside = sender.isOn
    }
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            Settings.shared.preferedStyle = .alert
        case 1:
            Settings.shared.preferedStyle = .topSheet(offset:  Settings.shared.offSet)
        case 2:
            Settings.shared.preferedStyle = .actionSheet(offset:  Settings.shared.offSet)
        case 3:
            Settings.shared.preferedStyle = .dragIn
        default:
            break
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

         jDNavigationController?.jDnavigationBar?.changeColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    }


    @IBAction func setStyle(_ sender: UIButton) {
        self.jDTabBarController?.tabBar.shapeType = Shape(rawValue: sender.tag) ?? Shape.upperRound
        
    }
    
    
}
