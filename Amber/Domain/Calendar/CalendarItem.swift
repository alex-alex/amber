//
//  CalendarItem.swift
//  Amber
//
//  Created by Alex Studnicka on 22.10.2021.
//

import Foundation

enum CalendarItemType {
	case diary
	case booking
	case medication
}

struct CalendarItem {

	var type: CalendarItemType
	var name: String
	var date: Date

}
