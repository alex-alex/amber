//
//  Extensions.swift
//  Amber
//
//  Created by Alex Studnicka on 22.10.2021.
//

import UIKit

// MARK: - UIView Properties

public extension UIView {

	@IBInspectable var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
		}
	}

	@IBInspectable var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}

	@IBInspectable var borderColor: UIColor? {
		get {
			guard let cgColor = layer.borderColor else { return nil }
			return UIColor(cgColor: cgColor)
		}
		set {
			layer.borderColor = newValue?.cgColor
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

	@IBInspectable var shadowColor: UIColor? {
		get {
			guard let cgColor = layer.shadowColor else { return nil }
			return UIColor(cgColor: cgColor)
		}
		set {
			layer.shadowColor = newValue?.cgColor
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

// MARK: - Storyboard

@IBDesignable
class IBButton: UIButton {}

// MARK: - Constraints

public extension UIView {
	
	@discardableResult
	func addVisualConstraints(H horizontal: String? = nil, V vertical: String? = nil, removeAutoresizing: Bool = true, view: UIView) -> [NSLayoutConstraint] {
		if removeAutoresizing && view.translatesAutoresizingMaskIntoConstraints {
			view.translatesAutoresizingMaskIntoConstraints = false
		}
		var layoutConstraints: [NSLayoutConstraint] = []
		if let horizontal = horizontal {
			layoutConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:"+horizontal, options: [], metrics: nil, views: ["v": view])
		}
		if let vertical = vertical {
			layoutConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:"+vertical, options: [], metrics: nil, views: ["v": view])
		}
		addConstraints(layoutConstraints)
		return layoutConstraints
	}

	func addFillConstraints(view: UIView, margin: Int = 0, removeAutoresizing: Bool = true) {
		addVisualConstraints(H: "|-(\(margin))-[v]-(\(margin))-|", V: "|-(\(margin))-[v]-(\(margin))-|", removeAutoresizing: removeAutoresizing, view: view)
	}

	func addSafeFillConstraints(view: UIView, margin: CGFloat = 0, removeAutoresizing: Bool = true) {
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
			view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: margin),
			view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
			view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: margin)
		])
		if removeAutoresizing && view.translatesAutoresizingMaskIntoConstraints {
			view.translatesAutoresizingMaskIntoConstraints = false
		}
	}

	func addCenterConstraintsForView(view: UIView, horizontal: Bool = true, vertical: Bool = true, removeAutoresizing: Bool = true) {
		if removeAutoresizing && view.translatesAutoresizingMaskIntoConstraints {
			view.translatesAutoresizingMaskIntoConstraints = false
		}
		if horizontal {
			view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		}
		if vertical {
			view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		}
	}

	@discardableResult
	func addEqualConstraint(
		view: UIView, relation: NSLayoutConstraint.Relation = .equal, attribute: NSLayoutConstraint.Attribute,
		multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
		let constraint = NSLayoutConstraint(
			item: view,
			attribute: attribute,
			relatedBy: relation,
			toItem: self,
			attribute: attribute,
			multiplier: multiplier,
			constant: constant
		)
		addConstraint(constraint)
		return constraint
	}

}

// MARK: - Date

extension Date {

	static func rangeOverlaps(lhs: (Date, Date), rhs: (Date, Date)) -> Bool {
		(lhs.0 <= rhs.1) && (lhs.1 >= rhs.0)
	}

}

// MARK: - UITraitCollection

extension UITraitCollection {

	var isDarkModeEnabled: Bool {
		userInterfaceStyle == .dark
	}

}
