//
//  AppTextField.swift
//  YAPKit
//
//  Created by Zain on 23/07/2019.
//  Copyright © 2019 YAP. All rights reserved.
//

import Foundation
import UIKit

open class AppTextField: UITextField {
    // MARK: - SubViews

    fileprivate lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .black
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var stateImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var tempPlaceholder: UILabel = {
        let label = UILabel()
        label.textColor = placeholderColor
        label.text = placeholder
        label.textAlignment = textAlignment
        label.font = font
        label.alpha = 0
        return label
    }()

    // MAKR: - Control properties
    private let padding = UIEdgeInsets(top: 15, left: 25, bottom: 15, right: 25)

    public var showsIcon: Bool = false {
        didSet {
            icon.isHidden = !showsIcon
        }
    }

    public var titleText: String? {
        get { return title.text }
        set (newValue) { title.text = newValue }
    }

    public var iconImage: UIImage? {
        get { return icon.image }
        set (newValue) {
            icon.image = newValue
            showsIcon = newValue != nil
        }
    }

    open override var text: String? {
        didSet {
            guard text?.count ?? 0 > 0, !isFirstResponder else { return }
            title.textColor = .black
            tempPlaceholder.text = nil
        }
    }

    open override var attributedText: NSAttributedString? {
        didSet {
            guard text?.count ?? 0 > 0, !isFirstResponder else { return }
            title.textColor = .gray
        }
    }

    public var placeholderColor: UIColor = UIColor.gray {
        didSet {
            let placeholder = self.placeholder
            self.placeholder = placeholder
        }
    }

    public override var placeholder: String? {
        didSet {
            guard  let `placeholder` = placeholder else { return }
            let attributedPlaceholder = NSMutableAttributedString(string: placeholder)
            attributedPlaceholder.addAttributes([.foregroundColor: self.placeholderColor], range: NSRange(location: 0, length: placeholder.count))
            self.attributedPlaceholder = attributedPlaceholder
        }
    }

    public var animatesTitleOnEditingBegin: Bool = true

    // MARK: Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

  convenience public  init(with placeholderText: String) {
        self.init(frame: .zero)
        placeholder = placeholderText
    }

    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
        tempPlaceholder.removeFromSuperview()
    }
}

// MARK: - Responder

extension AppTextField {
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        return super.becomeFirstResponder()
    }

    @discardableResult
    open override func resignFirstResponder() -> Bool {
        return super.resignFirstResponder()
    }
}

// MARK: Drawing

extension AppTextField {

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    private func rect(forBounds bounds: CGRect) -> CGRect {
        let originY = title.frame.origin.y + title.frame.size.height
        let height: CGFloat = 70
        return showsIcon ? CGRect(x: bounds.origin.x+40,
                                  y: originY,
                                  width: bounds.size.width - 70,
                                  height: height) :
            CGRect(x: bounds.origin.x + 30,
                   y: originY,
                   width: bounds.size.width - 30,
                   height: height)
    }
}

// MARK: - View setup

private extension AppTextField {
    func setupViews() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5
        if #available(iOS 13.0, *) {
            self.layer.borderColor = UIColor.systemGray6.cgColor
        } else {
            self.layer.borderColor = UIColor.lightGray.cgColor
            // Fallback on earlier versions
        }

       // addSubview(title)
        addSubview(icon)
        addSubview(stateImage)
        addSubview(bottomBar)
    //    addSubview(error)
    }

    func setupConstraints() {

        let iconConstraints = [
            icon.leadingAnchor.constraint(equalTo: leadingAnchor),
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            bottomBar.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 4),
            icon.widthAnchor.constraint(equalToConstant: 30)
        ]

        let stateImageConstraints = [
            trailingAnchor.constraint(equalTo: stateImage.trailingAnchor),
            stateImage.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            stateImage.heightAnchor.constraint(equalToConstant: 20),
            stateImage.widthAnchor.constraint(equalToConstant: 20)
        ]

        let bottomBarConstraints = [
            bottomBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 1)
        ]

        NSLayoutConstraint.activate(iconConstraints + stateImageConstraints  + bottomBarConstraints)
    }
}
