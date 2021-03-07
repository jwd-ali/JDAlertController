//
//  ViewController.swift
//  DialogueView
//
//  Created by Jawad Ali on 06/02/2021.
//  Copyright © 2021 Jawad Ali. All rights reserved.
//

import UIKit

open class AlertController: UIViewController {

    // MARK: - Views
    fileprivate lazy var mainStack = UIStackViewFactory.createStackView(with: .vertical,
                                                                        alignment: .center,
                                                                        distribution: .fill,
                                                                        spacing: 20)

    private lazy var animationView: AnimatedView? = {
        guard let type = type else {return nil}
        let animation = AnimatedView(logoLayer: type.animationLayer, color: type.color)
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()

    private lazy var icon: UIImageView? = UIImageViewFactory.createImageView(mode: .scaleAspectFit)

    private lazy var titleLabel = UILabelFactory.createUILabel(with: titleColor,
                                                               font: .bodySemibold,
                                                               alignment: .center, numberOfLines: 0,
                                                               lineBreakMode: .byWordWrapping)

    private lazy var descriptionLabel = UILabelFactory.createUILabel(with: .textLight, font: .headline, alignment: .center, numberOfLines: 0)

    fileprivate lazy var buttonStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 5)

     fileprivate lazy var textFieldsStack = UIStackViewFactory.createStackView(with: .vertical,
                                                                               alignment: .fill,
                                                                               distribution: .fillEqually,
                                                                               spacing: 5)

    fileprivate lazy var stack = UIStackViewFactory.createStackView(with: .vertical,
                                                                    alignment: .fill, distribution: .fill,
                                                                    spacing: 5, arrangedSubviews:
                                                                        [titleLabel,
                                                                         descriptionLabel])

    // MARK: Properties
    private var type: PopupType?
    fileprivate var horizantalButtons = false
    /// alertSize set `preferredContentSize` for the controller
    fileprivate  var alertSize: CGSize = .zero {
        didSet {
            preferredContentSize = alertSize
        }
    }
    private var physicsPan: PhysicsPanHandler?
    private let iconSize: CGFloat
    fileprivate var buttonHeight: CGFloat = 46
    private let textFieldHeight: CGFloat = 40

    open private(set) var actions: [PopupAction] = [] {
        didSet {
            setupButtons()
        }
    }

    open private(set) var textFields: [AppTextField] = [] {
        didSet {
            setupTextFields()
        }
    }

    // MARK: - Public Properties
    open var widthRatio: CGFloat  = 0.65
    open var cornerRadius: CGFloat = 10.0

    open var titleColor: UIColor = .textDark {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    open var isAnimated: Bool = false
    open var isDragEnable = false
    open var tapToClose = true

    open lazy var presentationManager: PopupPresentationManager  = {
        let manager = PopupPresentationManager()
        return manager
    }()

    // MARK: initializer

    public  init(type: PopupType? = nil,
                 icon: UIImage? = nil,
                 title: String? = nil,
                 message: String? = nil,
                 preferredStyle: PopupStyle = .actionSheet(offset: 0),
                 iconSize: CGFloat = 40) {
        self.iconSize = iconSize
        super.init( nibName: nil, bundle: nil)

        self.type = type
        self.icon?.image = icon
        self.titleLabel.text = title
        self.descriptionLabel.text = message

        presentationManager.type = preferredStyle
        modalPresentationStyle = .custom
        transitioningDelegate = presentationManager
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()

        if isAnimated {
            mainStack.arrangedSubviews.filter { $0 != animationView }.forEach {
                $0.isHidden = true
                $0.alpha = 0
            }
        }

        view.layoutIfNeeded()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addDragGestureIfEnabled()
        startAnimationIfEnabled()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        alertSize = CGSize(width: UIScreen.main.bounds.width*widthRatio, height: mainStack.frame.size.height + 40)
    }

    open func addAction(_ action: PopupAction) {
        actions.append(action)
    }

    open func addTextField(_ textField: AppTextField) {
        textFields.append(textField)
    }

   fileprivate func setupMainStack() {

    switch presentationManager.type {
    case .actionSheet, .topSheet:
        mainStack
        .alignEdgesWithSuperview([.left, .right], constants: [0, 0])
        .alignEdgeWithSuperviewSafeArea(.top, constant: 20)
        .alignEdgeWithSuperviewSafeArea(.bottom, .greaterThanOrEqualTo, constant: 20)
    default:
        mainStack
        .alignEdgesWithSuperview([.left, .right], constants: [0, 0])
        .alignEdgeWithSuperview(.top, constant: 20)
        .alignEdgeWithSuperview(.bottom, .greaterThanOrEqualTo, constant: 20)
    }
       
    }
}

// MARK: - Setup

private extension AlertController {
    func setupView() {
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.masksToBounds = false
        view.backgroundColor = .white

        view.addSubview(mainStack)

        if let icon = icon, icon.image != nil {
            mainStack.addArrangedSubview(icon)
        } else if let animationView = animationView {
            mainStack.addArrangedSubview(animationView)
        }

        mainStack.addArrangedSubview(stack)
        mainStack.addArrangedSubview(textFieldsStack)
        mainStack.addArrangedSubview(buttonStack)
    }

    func setupConstraints() {

        setupMainStack()

        stack
            .width(constant: UIScreen.main.bounds.maxX * widthRatio * 0.8 )

        if let icon = icon, icon.image != nil {
            icon
                .width( constant: iconSize)
                .height( constant: iconSize)
        } else if let animationView = animationView {
            animationView
                .width( constant: 150)
                .height(constant: 150)
        }
    }

    func setupTextFields() {
        textFieldsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        textFields.forEach {
            $0.removeAllConstraints()
            $0.translatesAutoresizingMaskIntoConstraints = false
          //  $0.height(constant: textFieldHeight)
            $0.width(.greaterThanOrEqualTo, constant: UIScreen.main.bounds.width*widthRatio-40)

            $0.alpha = isAnimated ? 0 : 1
            textFieldsStack.addArrangedSubview($0)
        }

        view.layoutIfNeeded()
    }

    func setupButtons() {
        buttonStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        actions.forEach {
            $0.removeAllConstraints()
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.height(constant: buttonHeight)
            if horizantalButtons {
                $0.width(.greaterThanOrEqualTo, constant: $0.buttonSize*UIScreen.main.bounds.width*widthRatio/CGFloat(actions.count)) } else {
                $0.width(.greaterThanOrEqualTo, constant: $0.buttonSize*UIScreen.main.bounds.width*widthRatio) }
            $0.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
            $0.alpha = isAnimated ? 0 : 1
            buttonStack.addArrangedSubview($0)
        }

        view.layoutIfNeeded()
    }

    @objc func dismissController() {
        physicsPan?.stop()
        self.dismiss(animated: true, completion: nil)
    }
}
private extension AlertController {
    func addDragGestureIfEnabled() {
        if isDragEnable {
            physicsPan = PhysicsPanHandler(messageView: view, containerView: view.superview) { [weak self] in self?.dismissController() }
        }
    }

    func startAnimationIfEnabled() {
        animationView?.startAnimation {[weak self] in

            let duration = 0.8

            UIView.animate(withDuration: duration, animations: {
                self?.mainStack.arrangedSubviews.forEach { $0.isHidden = false }
                self?.preferredContentSize = CGSize(width: UIScreen.main.bounds.width*(self?.widthRatio ?? 0), height: 600)
            }, completion: { (_) in
                self?.mainStack.arrangedSubviews.forEach { $0.alpha = 1 }

                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self?.buttonStack.arrangedSubviews.forEach { $0.alpha = 1 }
                    self?.textFieldsStack.arrangedSubviews.forEach { $0.alpha = 1 }
                }
            })
        }
    }
}
extension AlertController: DimmingViewTappedProtocol {
    public func dimmingViewTapped() {
        if tapToClose {
            dismissController()
        }
    }
}
open class BAlertController: AlertController {

    override var horizantalButtons: Bool {
        get { return true }
        set {}
    }

    override var buttonHeight: CGFloat {
    get { return 55 }
    set {}
    }

    override func setupMainStack() {

        mainStack
        .alignEdgesWithSuperview([.left, .right, .top], constants: [0, 0, 20])
        .alignEdgeWithSuperview(.bottom, .greaterThanOrEqualTo, constant: 0)

        mainStack.spacing = 45
        stack.spacing = 20
        buttonStack.axis = .horizontal
        buttonStack.spacing = 0
        buttonStack.distribution = .fillEqually

    }

    public override func viewDidLayoutSubviews() {
        alertSize = CGSize(width: UIScreen.main.bounds.width*widthRatio, height: mainStack.frame.size.height + 20)
    }

    public override func viewWillLayoutSubviews() {
           alertSize = CGSize(width: UIScreen.main.bounds.width*widthRatio, height: mainStack.frame.size.height + 20)
    }

}

open class CAlertController: AlertController {
    private lazy var crossButton = UIButtonFactory.createButton()

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupCView()
        setupCConstraints()
    }
}
private extension CAlertController {
    func setupCView() {
        crossButton.setImage(UIImage(named: "ic_close"), for: .normal)
        crossButton.addTarget(self, action: #selector(crossButtonTapped), for: .touchUpInside)
        view.addSubview(crossButton)
    }

    func setupCConstraints() {
        crossButton
            .width(constant: 25)
            .height(constant: 25)
            .alignEdgesWithSuperview([.right, .top], constants: [15, 15])
    }

    @objc private func crossButtonTapped() {
        dismissController()
    }
}
