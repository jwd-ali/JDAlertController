//
//  JDTableViewController.swift
//  Demo
//
//  Created by Jawad Ali on 04/03/2021.
//

import UIKit
import JDAlertController
class JDTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showSuccessAnimatedWithoutButton()
        case 1:
            showSuccessAnimated()
        case 2:
            showErrorAnimated()
        case 3:
            showInfoPoupup()
        case 4:
            showWriteUsPoupup()
        case 5:
            showAlertBottomAttached()
        case 6:
            showEatenAlert()
        case 7:
            showCookieAlert()
        case 8:
            showAccountCreatedAlert()
        case 9:
            showAppointmentAlert()
        case 10:
            moreAlert()
        case 11:
            signInAlert()
        default:
            break
        }
    }

}
extension JDTableViewController {

    private func showSuccessAnimatedWithoutButton() {
        let alert = AlertController(type: .success,
                                    title: "Awaiting your payment!",
                                    message: "Leo Walton will receive \n 62,500.00 PKR ",
                                    preferredStyle: Settings.shared.preferedStyle)
        alert.widthRatio = Settings.shared.widthRatio
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside
        alert.isAnimated = true

        self.present(alert, animated: true, completion: nil)

    }

    private func showSuccessAnimated() {
        let alert = AlertController(type: .success,
                                    title: "Awaiting your payment!",
                                    message: "Leo Walton will receive \n 62,500.00 PKR ",
                                    preferredStyle: Settings.shared.preferedStyle)

        alert.isAnimated = true
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside
        let continueButton = PopupAction(title: "Continue", style: .round, propotionalWidth: .custom(ratio: 0.5), handler: nil)
        continueButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        continueButton.backgroundColor = #colorLiteral(red: 0.1994869411, green: 0.857052505, blue: 0.9589684606, alpha: 1)

        alert.addAction(continueButton)

        self.present(alert, animated: true, completion: nil)

    }

    private func showErrorAnimated() {
        let alert = AlertController(type: .error,
                                    title: "Payment failed!",
                                    message: "It seems that we have not received money. You can try again ",
                                    preferredStyle: Settings.shared.preferedStyle)

        alert.isAnimated = true
        alert.widthRatio = Settings.shared.widthRatio
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside
        let alertButton = PopupAction(title: "Try Again", style: .round, propotionalWidth: .custom(ratio: 0.5), handler: nil)
        
        alertButton.setTitleColor(#colorLiteral(red: 0.987424314, green: 0.4821683764, blue: 0.4968466759, alpha: 1), for: .normal)

        alert.addAction(alertButton)

        let laterButton = PopupAction(title: "Maybe Later", style: .justText, propotionalWidth: .custom(ratio: 0.5), handler: nil)
        laterButton.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
        laterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        alert.addAction(laterButton)

        self.present(alert, animated: true, completion: nil)
    }

    private func showWriteUsPoupup() {

        let alert = AlertController(icon: UIImage(named: "write"),
                                    title: "Can We Help?",
                                    message: "Any questions or feedback? We are here to help you! ",
                                    preferredStyle: Settings.shared.preferedStyle,
                                    iconSize: 80)
        alert.widthRatio = Settings.shared.widthRatio
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside

        let helpAction = PopupAction(title: "Help & Feedback",
                                     style: .classic(cornerRadius: 5),
                                     propotionalWidth: .margin) {
            print("Move to the transfer details")
        }
        helpAction.setTitleColor(.white, for: .normal)
        helpAction.backgroundColor = #colorLiteral(red: 0.2085951865, green: 0.5907142758, blue: 0.8322908282, alpha: 1)
        alert.addAction(helpAction)

        let homeAction = PopupAction(title: "No, Thanks",
                                     style: .classic(cornerRadius: 5),
                                     propotionalWidth: .margin) {

        }

        homeAction.backgroundColor = .white
        homeAction.setTitleColor(#colorLiteral(red: 0.3050502539, green: 0.3099033833, blue: 0.3141470551, alpha: 1), for: .normal)
        alert.addAction(homeAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func showInfoPoupup() {

        let alert = AlertController(icon: UIImage(named: "clock"),
                                    title: "Awaiting your payment!",
                                    message: "Leo Walton will receive \n 62,500.00 PKR ",
                                    preferredStyle: Settings.shared.preferedStyle)
        alert.widthRatio = Settings.shared.widthRatio

        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside
        let transferAction = PopupAction(title: "Move to the transfer details", style: .default, propotionalWidth: .full) {
            print("Move to the transfer details")
        }
        alert.addAction(transferAction)

        let homeAction = PopupAction(title: "Back to home screen", style: .default, propotionalWidth: .full) {

        }

        alert.addAction(homeAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func showAlertBottomAttached() {
        let alert = BAlertController(icon: UIImage(named: "alert"),
                                     title: "Notify Me On Orders",
                                     message: "Allow push notifications so you will know when a new order arrives ",
                                     preferredStyle: Settings.shared.preferedStyle,
                                     iconSize: 200)
        alert.widthRatio = Settings.shared.widthRatio
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside
        let notNowAction = PopupAction(title: "NOT NOW", style: .classic(cornerRadius: 0), propotionalWidth: .full) {
            print("Move to the transfer details")
        }
        notNowAction.backgroundColor = #colorLiteral(red: 0.9161294103, green: 0.9698380828, blue: 0.999430716, alpha: 1)
        notNowAction.setTitleColor(#colorLiteral(red: 0.3053192198, green: 0.7174723744, blue: 0.958769381, alpha: 1), for: .normal)
        alert.addAction(notNowAction)

        let okAction = PopupAction(title: "OK", style: .classic(cornerRadius: 0), propotionalWidth: .full) {

        }
        okAction.backgroundColor = #colorLiteral(red: 0.2209088206, green: 0.6000856161, blue: 0.9274522662, alpha: 1)
        okAction.setTitleColor(.white, for: .normal)
        alert.addAction(okAction)

        alert.view.clipsToBounds = true

        self.present(alert, animated: true, completion: nil)
    }

    private func showEatenAlert() {
        let alert = CAlertController(icon: UIImage(named: "eaten"),
                                     title: "yay!!",
                                     message: "You have successfully eaten everyone's bacon",
                                     preferredStyle: Settings.shared.preferedStyle,
                                     iconSize: 150)
        alert.widthRatio = Settings.shared.widthRatio

        alert.cornerRadius = 30
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside
        let notNowAction = PopupAction(title: "OK, COOL", style: .justText, propotionalWidth: .full) {
            print("Move to the transfer details")
        }

        notNowAction.setTitleColor(#colorLiteral(red: 0.208910495, green: 0.7625507712, blue: 0.5491705537, alpha: 1), for: .normal)
        notNowAction.titleLabel?.font = UIFont.boldSystemFont(ofSize: notNowAction.titleLabel?.font.pointSize ?? 16)
        alert.addAction(notNowAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func showCookieAlert() {
        let alert = AlertController(icon: UIImage(named: "cookie"),
                                    message: "Our application uses cookies to ensure you get the best experience while you are here",
                                    preferredStyle: Settings.shared.preferedStyle,
                                    iconSize: 150)
        alert.widthRatio = Settings.shared.widthRatio
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside
        alert.cornerRadius = 5

        let okayAction = PopupAction(title: "Okay", style: .classic(cornerRadius: 5), propotionalWidth: .custom(ratio: 0.7)) {
            print("Move to the transfer details")
        }

        okayAction.setTitleColor(.white, for: .normal)
        okayAction.backgroundColor = #colorLiteral(red: 0.6181281209, green: 0.790913403, blue: 0.2387955189, alpha: 1)

        alert.addAction(okayAction)

        let learnMoreAction = PopupAction(title: "LEARN MORE", style: .justText, propotionalWidth: .custom(ratio: 0.5)) {
            print("Move to the transfer details")
        }

        learnMoreAction.setTitleColor(#colorLiteral(red: 0.5019147992, green: 0.5019902587, blue: 0.5018982291, alpha: 1), for: .normal)
        alert.addAction(learnMoreAction)
        learnMoreAction.titleLabel?.font = UIFont.boldSystemFont(ofSize: learnMoreAction.titleLabel?.font.pointSize ?? 16)
        self.present(alert, animated: true, completion: nil)
    }

    private func showAccountCreatedAlert() {
        let alert = AlertController(icon: UIImage(named: "account"),
                                    title: "Your account was created!",
                                    message: "Congratulations! You just created an account. Now you can log in or save password for later.",
                                    preferredStyle: Settings.shared.preferedStyle,
                                    iconSize: 80)
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside

        alert.widthRatio = Settings.shared.widthRatio

        alert.cornerRadius = 40

        let okayAction = PopupAction(title: "Log in", style: .classic(cornerRadius: 10), propotionalWidth: .custom(ratio: 0.85)) {
            print("Move to the transfer details")
        }

        okayAction.setTitleColor(.white, for: .normal)
        okayAction.backgroundColor = #colorLiteral(red: 0.1609114707, green: 0.570215106, blue: 0.9703096747, alpha: 1)

        alert.addAction(okayAction)

        let learnMoreAction = PopupAction(title: "Save password to log in later", style: .justText, propotionalWidth: .custom(ratio: 0.85)) {
            print("Move to the transfer details")
        }

        learnMoreAction.setTitleColor(#colorLiteral(red: 0.1609114707, green: 0.570215106, blue: 0.9703096747, alpha: 1), for: .normal)
        learnMoreAction.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        alert.addAction(learnMoreAction)

        self.present(alert, animated: true, completion: nil)
    }
    private func showAppointmentAlert() {
        let alert = AlertController(icon: UIImage(named: "appointment"),
                                    title: "You have an Appointment today!",
                                    message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
                                    preferredStyle: Settings.shared.preferedStyle,
                                    iconSize: 180)
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside
        alert.widthRatio = Settings.shared.widthRatio
        alert.cornerRadius = 5

        let okayAction = PopupAction(title: "OK, GOT IT", style: .round, propotionalWidth: .custom(ratio: 0.4)) {
            print("Move to the transfer details")
        }

        okayAction.setTitleColor(.white, for: .normal)
        okayAction.backgroundColor = #colorLiteral(red: 0.9618458152, green: 0.3609481752, blue: 0.5274584889, alpha: 1)

        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }

    private func moreAlert() {
        let alert = AlertController(title: "More", preferredStyle: Settings.shared.preferedStyle)

        alert.widthRatio = Settings.shared.widthRatio
        alert.cornerRadius = 10
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside

        alert.titleColor = #colorLiteral(red: 0.3127508163, green: 0.3984804451, blue: 0.401491344, alpha: 1)

        let fbAction = PopupAction(title: "Share to Facebook", style: .classic(cornerRadius: 5), propotionalWidth: .margin) {
            print("Move to the transfer details")
        }

        fbAction.setTitleColor(#colorLiteral(red: 0.5007678866, green: 0.5505910516, blue: 0.5496833324, alpha: 1), for: .normal)
        fbAction.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2997156091)
        alert.addAction(fbAction)

        let twitterAction = PopupAction(title: "Share to Twitter", style: .classic(cornerRadius: 5), propotionalWidth: .margin) {
            print("Move to the transfer details")
        }

        twitterAction.setTitleColor(#colorLiteral(red: 0.5007678866, green: 0.5505910516, blue: 0.5496833324, alpha: 1), for: .normal)
        twitterAction.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2975452527)

        alert.addAction(twitterAction)

        let frndsAction = PopupAction(title: "Invite Friends ", style: .classic(cornerRadius: 5), propotionalWidth: .margin) {
            print("Move to the transfer details")
        }

        frndsAction.setTitleColor(.white, for: .normal)
        frndsAction.backgroundColor = #colorLiteral(red: 0.6089134216, green: 0.3504202366, blue: 0.7142890096, alpha: 1)

        alert.addAction(frndsAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func signInAlert() {
        let alert = AlertController(title: "Sign in",
                                    message: "You can always access your contents by signig back in.",
                                    preferredStyle: Settings.shared.preferedStyle)

        alert.widthRatio = Settings.shared.widthRatio
        alert.cornerRadius = 10
        alert.isDragEnable = Settings.shared.isDragEnabled
        alert.tapToClose = Settings.shared.dismissOuside

        let emailField = AppTextField(with: "User Name or Email")
        let passwordField = AppTextField(with: "Password")
        passwordField.isSecureTextEntry = true

        alert.addTextField(emailField)
        alert.addTextField(passwordField)

        let signinAction = PopupAction(title: "Sign in", style: .classic(cornerRadius: 5), propotionalWidth: .margin)
        signinAction.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        signinAction.backgroundColor = #colorLiteral(red: 0.02145463601, green: 0.994926393, blue: 0.7086910605, alpha: 1)
        alert.addAction(signinAction)

        let forgetAction = PopupAction(title: "I forgot my password", style: .justText, propotionalWidth: .margin)
        alert.addAction(forgetAction)

        let blankAction = PopupAction(title: "", style: .justText, propotionalWidth: .margin)
        alert.addAction(blankAction)

        let fbAction = PopupAction(title: "Connect with Facebook", style: .classic(cornerRadius: 5), propotionalWidth: .margin)
        fbAction.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        fbAction.backgroundColor = #colorLiteral(red: 0.2288119793, green: 0.3499016464, blue: 0.5981587768, alpha: 1)
        alert.addAction(fbAction)

        let twitterAction = PopupAction(title: "Connect with Twitter", style: .classic(cornerRadius: 5), propotionalWidth: .margin)
        twitterAction.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        twitterAction.backgroundColor = #colorLiteral(red: 0.324909389, green: 0.7267069817, blue: 0.9079041481, alpha: 1)
        alert.addAction(twitterAction)

        let frndsAction = PopupAction(title: "Connect with Google", style: .classic(cornerRadius: 5), propotionalWidth: .margin)
        frndsAction.setTitleColor(.white, for: .normal)
        frndsAction.backgroundColor = #colorLiteral(red: 0.828327775, green: 0.2797490358, blue: 0.2128782272, alpha: 1)
        alert.addAction(frndsAction)

        let signupAction = PopupAction(title: "Don't have a account?", style: .justText, propotionalWidth: .margin)
        alert.addAction(signupAction)
        self.present(alert, animated: true, completion: nil)
    }

}
