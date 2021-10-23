//
//  CalendarItemCell.swift
//  Amber
//
//  Created by Alex Studnicka on 22.10.2021.
//

import UIKit

class CalendarItemCell: UITableViewCell {

	let titleLabel = UILabel()
	let dotView = UIView()
	let typeLabel = UILabel()
	let timeLabel = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	func setup() {
		selectionStyle = .none

		backgroundColor = .clear
		contentView.backgroundColor = .clear

		let mainStackView = UIStackView()
		mainStackView.axis = .horizontal
		mainStackView.alignment = .center
		mainStackView.spacing = 8
		contentView.addSubview(mainStackView)
		contentView.addFillConstraints(view: mainStackView, margin: 16)

		let verticalStackView = UIStackView()
		verticalStackView.axis = .vertical
		verticalStackView.spacing = 4
		mainStackView.addArrangedSubview(verticalStackView)

		titleLabel.textColor = .black
//		titleLabel.font = .subtitle
		verticalStackView.addArrangedSubview(titleLabel)

		let horizontalStackView = UIStackView()
		horizontalStackView.axis = .horizontal
		horizontalStackView.spacing = 4
		verticalStackView.addArrangedSubview(horizontalStackView)
		horizontalStackView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.75).isActive = true

		let dotViewContainer = UIView()
		horizontalStackView.addArrangedSubview(dotViewContainer)
		dotViewContainer.widthAnchor.constraint(equalToConstant: 10).isActive = true

		dotView.backgroundColor = .systemRed
		dotView.clipsToBounds = true
		dotView.cornerRadius = 3
		dotViewContainer.addSubview(dotView)
		dotViewContainer.addCenterConstraintsForView(view: dotView, horizontal: false, vertical: true)
		dotView.leftAnchor.constraint(equalTo: dotViewContainer.leftAnchor).isActive = true
		dotView.widthAnchor.constraint(equalToConstant: 6).isActive = true
		dotView.heightAnchor.constraint(equalToConstant: 6).isActive = true

		typeLabel.textColor = .darkGray
//		typeLabel.font = .text
		typeLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
		horizontalStackView.addArrangedSubview(typeLabel)

		timeLabel.textColor = .black
//		timeLabel.font = .text
		horizontalStackView.addArrangedSubview(timeLabel)

		let viewButton = UIButton(configuration: .gray(), primaryAction: nil)
//		viewButton.titleLabel?.font = .text
		viewButton.setTitle("View", for: .normal)
		mainStackView.addArrangedSubview(viewButton)
		viewButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
		viewButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
	}

}
