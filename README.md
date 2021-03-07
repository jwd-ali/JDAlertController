<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/header/header.png">
<img align="right" src="https://github.com/jwd-ali/JDAlertController/blob/main/images/JDAlertController.gif" width="480" />
<p><h1 align="left">JDAlertController</h1></p>

[![CI Status](https://travis-ci.org/jwd-ali/RingPieChart.svg)](https://travis-ci.org/jwd-ali/RingPieChart)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/RingPieChart.svg?style=flat)](https://cocoapods.org/pods/RingPieChart)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-0473B3.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/RingPieChart.svg?style=flat)](https://cocoapods.org/pods/RingPieChart)
[![Platform](https://img.shields.io/cocoapods/p/RingPieChart.svg?style=flat)](https://cocoapods.org/pods/RingPieChart)
[![Swift 5.1](https://img.shields.io/badge/swift-5.1-orange)](https://swift.org)

<p><h4>JDAlertController is AlertController replica that can significantly enhance your users’ experiences and set your app apart from the rest of the pack.</h4></p>

___
You don’t need to do much to integrate it. Its build using UIViewControllerTransitioningDelegate and UIPresentationController having four types of UIViewControllerAnimatedTransitioning animations and many more customisations with different buttons styles and UITextField support as well

Error and Success Animations are build using CABasicAnimation and CAShapeLayer through UIBezierpath. Its fun to play with CoreGraphics.It starts slow and By the end, you’ll be able to create stunning graphics for your apps.
<p> 
  

<a href="https://www.linkedin.com/in/jawad-ali-3804ab24/"><img src="https://i.imgur.com/vGjsQPt.png" width="134" height="34"></a>  

</br></br>
## Requirements

- iOS 11.0+ / Mac OS X 10.9+ / watchOS 2.0+ / tvOS 9.0+
- Xcode 8.0+

## Installation

### [CocoaPods](http://cocoapods.org)

To integrate **JDAlertController** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'JDAlertController'
```

Then, run the following command:

```bash
$ pod install
```
### [Carthage](http://github.com/Carthage/Carthage)

To integrate `JDAlertController` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "jwd-ali/JDAlertController"
```

### [Swift Package Manager (SPM)](https://swift.org/package-manager)

#### Prerequisites
- OSX


#### Update `Package.swift`
To integrate `JDAlertController` in your project, add the proper description to your `Package.swift` file:
```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/jwd-ali/JDAlertController.git")
    ],
    targets: [
        .target(
            name: "YOUR_TARGET_NAME",
            dependencies: ["JDAlertController"]
        ),
        ...
    ]
)
```

### Manually

If you prefer not to use a dependency manager, you can integrate JDAlertController into your project manually.

- Add sources into your project:
  - Drag `Sources`

## Usage

> If you are using any dependency manager (pods , carthage , package manager)to integrate JDAlertController. Import JDAlertController first:
> ```swift
> import JDAlertController
> ```

> And for Manuall install you dont need to import anything 

- Init your ring with  `Alert` same as you initialize default `UIAlertController`:
```swift
  let alert = AlertController(icon: UIImage(named: "iconName"),
                                    title: "Can We Help?",
                                    message: "Any questions or feedback? We are here to help you! ",
                                    preferredStyle: .alert)
```
We can show alert with 4 different styles 

```swift
public enum PopupStyle {
    case alert
    case actionSheet(offset: Double)
    case topSheet(offset: Double)
    case dragIn
}
```

Action sheet and top sheet support offset as well if you want to position it some point rather then attaching to bottom or top
You can also set the icon size in the initializer like this 

```swift
let alert = AlertController(icon: UIImage(named: "write"),
                                    title: "Can We Help?",
                                    message: "Any questions or feedback? We are here to help you! ",
                                    preferredStyle: Settings.shared.preferedStyle,
                                    iconSize: 80)
```

Here you are giving top icon size to 80 points

You can enable touch anywhere outside the alert to dismiss it on 

```swift
alert.tapToClose = true

```
If its On user can tap anywhere outside popup to dismiss it.

You can also enable draging and fast drag dismiss by setting the key `isDragEnable` 

```swift
alert.isDragEnable = true

```
You can control the width of the popup using key `widthRatio` ita ratio of total screen width. its value should be in range 0...1 

```swift
alert.widthRatio = 0.8

```

For Animated success or failure you need to set PopupType in inializer like this

```swift
public enum PopupType {
    case success
    case error
}

let alert = AlertController(type: .success,
                                    title: "Awaiting your payment!",
                                    message: "Leo Walton will receive \n 62,500.00 PKR ",
                                    preferredStyle: Settings.shared.preferedStyle)

```

And set the `isAnimated` property to true if you want Top to bottom animation like unfolding


```swift
 alert.isAnimated = true
```


Adding `buttons` and `TextFields` in alert is as simple as adding them in Alert controller

```swift
 let homeAction = PopupAction(title: "No, Thanks",
                                     style: .classic(cornerRadius: 5),
                                     propotionalWidth: .margin) {

        }
        
        alert.addAction(homeAction)
```

Same as AlertController we get closure to do actions while declaring buttons and dismissal of popup is auto so you dont need to dismiss the alert on taping of the button
We have different style buttons available to inject into the Action

```swift
 public enum Style {

        case `default`
        case bold
        case destructive
        case round
        case classic(cornerRadius: CGFloat)
        case justText
    }
```
I think they are self explainatory as their name. Also you can have sizes of buttons as well

```swift
public enum ButtonWidth {
        case full
        case margin
        case normal
        case custom(ratio: CGFloat)
    }
```
Where full are full width and you can also have custom width and marginal width as well
here is the propotinal width graph

```swift
var buttonSize: CGFloat {
            switch propotionalWidth {
            case .full:
                return 1.0
            case .margin:
                return 0.9
            case .normal:
                return 0.75
            case .custom(let width):
                return width
            }
        }
```

It explain the width of the button

Adding Text fields is also as easy as its native control

```swift
 let emailField = AppTextField(with: "User Name or Email")
        let passwordField = AppTextField(with: "Password")
        passwordField.isSecureTextEntry = true

        alert.addTextField(emailField)
        alert.addTextField(passwordField)

```

And then you can access them like this

```swift
  let firstTextField =  alert.textFields.first
  ```

Congratulations! You're done.


## Contributing

I’d love to have help on this project. For small changes please [open a pull request](https://github.com/jwd-ali/JDAlertController/pulls), for larger changes please [open an issue](https://github.com/jwd-ali/JDAlertController/issues) first to discuss what you’d like to see.


License
-------

JDAlertController is under [MIT](https://opensource.org/licenses/MIT). See [LICENSE](LICENSE) file for more info.
