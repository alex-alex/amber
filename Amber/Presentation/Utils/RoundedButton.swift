//
//  RoundedButton.swift
//  Amber
//
//  Created by Alex Studnicka on 22.10.2021.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

	class func make(isSmall: Bool = false) -> Self {
		let button = self.init(type: .system)
		button.setup(isSmall: isSmall)
		return button
	}

	class func makeSmall() -> Self {
		return make(isSmall: true)
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		updateStyle()
	}

	var isAppSelected: Bool = false {
		didSet { updateStyle() }
	}

	override var isEnabled: Bool {
		didSet { updateStyle() }
	}

	open func setup(isSmall: Bool = false) {
		cornerRadius = 6
//		titleLabel?.font = isSmall ? .smallButton : .largeButton
		contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		updateStyle()
	}

	func updateStyle() {
		if !isEnabled {
			backgroundColor = .lightGray
			tintColor = .darkGray
			borderWidth = 0
		} else if isAppSelected {
			backgroundColor = .black
			if traitCollection.isDarkModeEnabled {
				tintColor = .white
				borderColor = .darkGray
				borderWidth = 1.5
			} else {
				tintColor = .white
				borderWidth = 0
			}
		} else {
			if traitCollection.isDarkModeEnabled {
				tintColor = .white
				backgroundColor = .lightGray
				borderWidth = 0
			} else {
				tintColor = .black
				backgroundColor = .clear
				borderColor = .systemPink
				borderWidth = 1.5
			}
		}
		setTitleColor(.systemPink, for: .normal)
	}

}
