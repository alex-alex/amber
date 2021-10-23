//
//  FilledButton.swift
//  Amber
//
//  Created by Alex Studnicka on 23.10.2021.
//

import UIKit

class FilledButton: UIButton {

	override open var isHighlighted: Bool {
		didSet {
			configuration?.baseForegroundColor = isHighlighted ? .white : .accent
			configuration?.background.backgroundColor = isHighlighted ? .accent : .clear
		}
	}

}
