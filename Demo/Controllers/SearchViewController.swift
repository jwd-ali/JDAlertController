//
//  SearchViewController.swift
//  Demo
//
//  Created by Jawad Ali on 10/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import JDAlertController
class SearchViewController: UIViewController {

    override func viewDidLoad() {
        self.title = "Search"

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

           jDNavigationController?.jDnavigationBar?.changeColor(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1))

       }

    @IBAction private func changeTintColor(_ sender: UIButton) {
       // jDTabBarController?.tabBar.tabBarTintColor = sender.backgroundColor ?? .white

        showSuccessAnimated()
    }
    private func showSuccessAnimated() {
       let alert = AlertController(type: .success,
                                   title: "Awaiting your payment!",
                                   message: "Leo Walton will receive \n 62,500.00 PKR ",
                                   preferredStyle: .alert)

       alert.isAnimated = true

       let continueButton = PopupAction(title: "Continue", style: .round, propotionalWidth: .custom(ratio: 0.5), handler: nil)
       continueButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
       continueButton.backgroundColor = #colorLiteral(red: 0.1994869411, green: 0.857052505, blue: 0.9589684606, alpha: 1)

       alert.addAction(continueButton)

       self.present(alert, animated: true, completion: nil)

   }

}
