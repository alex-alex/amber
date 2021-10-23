//
//  SFCalendar.swift
//  Amber
//
//  Created by Alex Studnicka on 22.10.2021.
//

import UIKit
import FSCalendar

final class SFCalendar: FSCalendar {

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonSetup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonSetup()
	}

	private func commonSetup() {
		scope = .month
		placeholderType = .none

		let locale = Locale(identifier: "en")
		let calendar = Calendar(identifier: .gregorian)

		self.locale = locale
		firstWeekday = UInt(calendar.firstWeekday)

		appearance.headerDateFormat = DateFormatter.dateFormat(fromTemplate: "MMMMyyyy", options: 0, locale: locale)
		appearance.headerTitleColor = .black
//		appearance.headerTitleFont = .subtitle

		appearance.caseOptions = .weekdayUsesSingleUpperCase
		appearance.weekdayTextColor = .black
//		appearance.weekdayFont = .label

		appearance.borderRadius = 1
//		appearance.titleFont = .text
		appearance.titleDefaultColor = .black
		appearance.titleWeekendColor = .darkGray
		appearance.eventDefaultColor = .systemRed

		appearance.selectionColor = .systemPink
		appearance.todaySelectionColor = .systemPink
		appearance.eventSelectionColor = .clear

		appearance.todayColor = .clear
		appearance.titleTodayColor = .systemPink
	}

}
