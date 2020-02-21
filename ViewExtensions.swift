//
//  ViewExtensions.swift
//  PinHeaderTables
//
//  Created by sreekanth reddy iragam reddy on 2/17/20.
//  Copyright © 2020 TablesPinHeader. All rights reserved.
//

import UIKit

extension UIView {

    func addToEdgeConstraints(_ view: UIView, _ insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        ])
    }

    func addSubviewAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    class var className: String {
        return String(describing: self)
    }

    class var reuseIdentifier: String {
        return className
    }

    class var bundle: Bundle {
        return Bundle(for: self)
    }

    class var nibName: String {
        return className
    }

    class var nib: UINib {
        let nibName = self.nibName
        let bundle = self.bundle
        return UINib(nibName: nibName, bundle: bundle)
    }

    open func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)

        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            return view
        }

        return UIView()

    }

    // For Views created in swift
    static func instantiateFromNib() -> Self? {
        return instanceFromNib()
    }

    static func instanceFromNib<T: UIView>() -> T? {
        let nib: UINib = UINib(nibName: self.nibName, bundle: nil)
        guard let views: [UIView] = nib.instantiate(withOwner: nil, options: nil) as? [UIView],
            let view: T = views.first as? T else {
                return nil
        }
        return view
    }

    func pinView(viewIdentifier: String, toView mainView: UIView) {
        let viewsDictionary: [String: UIView] = [viewIdentifier: mainView]

        let horizontal: String = String(format: "H:|[" + viewIdentifier + "]|")
        let horizontalConstraints = constrains(withVisualFormat: horizontal, viewsDictionary: viewsDictionary)
        for constraint in horizontalConstraints {
            constraint.isActive = true
        }

        let vertical: String = String(format: "V:|[" + viewIdentifier + "]|")
        let verticalConstraints = constrains(withVisualFormat: vertical, viewsDictionary: viewsDictionary)
        for constraint in verticalConstraints {
            constraint.isActive = true
        }
    }

    public func fillSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)

        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["subview": subview])
        for constraint in horizontalConstraints {
            constraint.isActive = true
        }
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["subview": subview])
        for constraint in verticalConstraints {
            constraint.isActive = true
        }
    }

    func constrains(withVisualFormat visualFormat: String, viewsDictionary: [String: UIView]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormat,
                                              options: [],
                                              metrics: nil,
                                              views: viewsDictionary)
    }

    public func addAccessibilityTraits(label: String? = nil, hint: String? = nil, identifier: String? = nil, value: String? = nil) {
        isAccessibilityElement = true
        if let label = label {
            accessibilityLabel = label
        }
        if let hint = hint {
            accessibilityHint = hint
        }
        if let identifier = identifier {
            accessibilityIdentifier = identifier
        }
        if let value = value {
            accessibilityValue = value
        }
    }

    /// Returns the ViewController in which the view resides in.
    func getCurrentViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.getCurrentViewController()
        } else {
            return nil
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
}
