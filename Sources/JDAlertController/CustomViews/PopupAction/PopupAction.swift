//
//  PopupButton.swift
//  Vowpay
//
//  Created by Jawad Ali on 28/01/2021.
//  Copyright © 2021 Vowpay. All rights reserved.
//

import UIKit

public typealias Action = () -> Void

extension PopupAction {

    public enum ButtonWidth {
        case full
        case margin
        case normal
        case custom(ratio: CGFloat)
    }

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

    public enum Style {

        case `default`
        case bold
        case destructive
        case round
        case classic(cornerRadius: CGFloat)
        case justText
    }

    private func applyStyle() {
        switch style {

        case .default:
            print("default 000")
        case .bold:
            titleLabel?.font = UIFont.boldSystemFont(ofSize: titleLabel?.font.pointSize ?? 16)
        case .destructive:
            self.setTitleColor(.red, for: .normal)
        case .round:
            borderView.isHidden = true
            self.layer.cornerRadius = bounds.midY
            self.layer.borderWidth = 2
            self.layer.borderColor = self.titleLabel?.textColor.cgColor
            titleLabel?.font = UIFont.boldSystemFont(ofSize: titleLabel?.font.pointSize ?? 16)
            addShadow()
        case .classic(let corner):
            addShadow()
            borderView.isHidden = true
            layer.cornerRadius = corner
            titleLabel?.font = UIFont.boldSystemFont(ofSize: titleLabel?.font.pointSize ?? 16)
        case .justText:
            borderView.isHidden = true
            backgroundColor = .clear
        }
    }
}

open class PopupAction: UIButton {
    // MARK: - Views
    private lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .border
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties
    private var action: Action?
    private var titleText: String?
    private(set) var style: Style
    private(set) var propotionalWidth: ButtonWidth

    open override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)

        layer.borderColor = color?.cgColor
    }
    open override func willMove(toSuperview newSuperview: UIView?) {
        borderView
            .alignEdgesWithSuperview([.left, .right, .top])
            .height(constant: 1.5)
    }
    // MARK: - Initializer
    public init(title: String, style: Style = .default, propotionalWidth: ButtonWidth = .full, handler: Action? = nil) {
        self.style = style
        self.propotionalWidth = propotionalWidth
        super.init(frame: .zero)

        self.action = handler
        self.titleText = title
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
        setupConstraints()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Shadow
    func addShadow() {
        layer.shadowColor = UIColor.textDark.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        backgroundColor = self.backgroundColor == .clear ? .white : backgroundColor
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        applyStyle()
    }
}

// MARK: - Setup & bind
private extension PopupAction {
    func setupView() {
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        setTitleColor(.primary, for: .normal)
        setTitle(titleText, for: .normal)
        addSubview(borderView)

        applyStyle()
    }

    @objc func buttonTapped() {
        if let action =  action {
            action()
        }
    }

    func setupConstraints() {

    }

}
