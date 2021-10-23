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
		titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
		verticalStackView.addArrangedSubview(titleLabel)

		let horizontalStackView = UIStackView()
		horizontalStackView.axis = .horizontal
		horizontalStackView.spacing = 4
		verticalStackView.addArrangedSubview(horizontalStackView)
		horizontalStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
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
		typeLabel.font = UIFont(name: "HelveticaNeue", size: 12)
		horizontalStackView.addArrangedSubview(typeLabel)

		timeLabel.textColor = .accent
		timeLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
		horizontalStackView.addArrangedSubview(timeLabel)
	}

}
