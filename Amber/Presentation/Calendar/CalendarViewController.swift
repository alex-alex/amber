//
//  CalendarViewController.swift
//  Amber
//
//  Created by Alex Studnicka on 22.10.2021.
//

import UIKit
import FSCalendar
import DateToolsSwift

final class MyCalendarViewController: UIViewController {

	var calendarView = SFCalendar(frame: .zero)
	var calendarHeightConstraint: NSLayoutConstraint!
	let tableView = UITableView(frame: .zero, style: .plain)

	fileprivate lazy var scopeGesture: UIPanGestureRecognizer = { [unowned self] in
		let panGesture = UIPanGestureRecognizer(target: calendarView, action: #selector(calendarView.handleScopeGesture(_:)))
		panGesture.delegate = self
		panGesture.minimumNumberOfTouches = 1
		panGesture.maximumNumberOfTouches = 2
		return panGesture
	}()

	private let numberFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.locale = .current
		return formatter
	}()

	private let timeFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeStyle = .short
		return formatter
	}()

	var monthsLoading = Set<Date>()
	var bookingData: [Date: [CalendarItem]] = [:]
	var selectedDayData: [CalendarItem] = []

	var dateSelected = false

}

// MARK: - UIViewController

extension MyCalendarViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.backButtonTitle = "Back"
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(setToday))

		calendarView.backgroundColor = .white
		calendarView.select(Date())
		calendarView.dataSource = self
		calendarView.delegate = self
		view.addSubview(calendarView)
		view.addVisualConstraints(H: "|-0-[v]-0-|", view: calendarView)
		calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		calendarHeightConstraint = calendarView.heightAnchor.constraint(equalToConstant: 300)
		calendarHeightConstraint.isActive = true

		if UIDevice.current.userInterfaceIdiom == .pad {
			self.calendarHeightConstraint.constant = 400
		}

		tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
		tableView.backgroundColor = .white
		tableView.separatorColor = .lightGray
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		tableView.rowHeight = 80
		tableView.alwaysBounceVertical = true
		tableView.delaysContentTouches = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(CalendarItemCell.self, forCellReuseIdentifier: "CalendarItemCell")
		view.addSubview(tableView)
		view.addVisualConstraints(H: "|-0-[v]-0-|", view: tableView)
		tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

		view.addGestureRecognizer(scopeGesture)
		tableView.panGestureRecognizer.require(toFail: scopeGesture)

		updateItems()
	}

}

// MARK: - Private

extension MyCalendarViewController {

	private func updateItems() {
		let selectedMonth = calendarView.currentPage.start(of: .month)
//		let bookings = viewModel.bookings.value // .filter({ $0.reservationDetails.interval != nil })

		let start = selectedMonth.add(14.hours)
		var array: [CalendarItem] = []

		for i in 0 ..< 31 where i % 2 == 0 {
			array.append(CalendarItem(type: .medication, name: "Ibuprofen", date: start.add(i.days)))
		}

		for i in 0 ..< 25 where Bool.random() {
			array.append(CalendarItem(type: .diary, name: "Chest pain", date: start.add(i.days)))
		}

		array.append(CalendarItem(type: .booking, name: "Physical examination", date: start.add(4.days)))
		array.append(CalendarItem(type: .booking, name: "Physical examination", date: start.add(11.days)))
		array.append(CalendarItem(type: .booking, name: "Physical examination", date: start.add(18.days)))
		array.append(CalendarItem(type: .booking, name: "Physical examination", date: start.add(25.days)))

		self.bookingData[selectedMonth] = array
		self.calendarView.reloadData()
		self.setSelectedDay()
	}

}

// MARK: - FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance

extension MyCalendarViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

	func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
		let component = Calendar(identifier: .gregorian).component(.day, from: date)
		return numberFormatter.string(from: component as NSNumber)
	}

	func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
		return self.calendar(calendar, appearance: calendar.appearance, eventDefaultColorsFor: date)?.count ?? 0
	}

	func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
		let day = date.start(of: .day)
		let month = date.start(of: .month)
		var array: [UIColor] = []

		if let reservations = bookingData[month] {
			let dayItems = reservations.filter({ $0.date.start(of: .day) == day })

			if !dayItems.filter({ $0.type == .diary }).isEmpty { array.append(.accent) }
			if !dayItems.filter({ $0.type == .medication }).isEmpty { array.append(.tertiary) }
			if !dayItems.filter({ $0.type == .booking }).isEmpty { array.append(.secondary) }
		}

		return array
	}

	func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
		self.calendarHeightConstraint.constant = bounds.height
		self.view.layoutIfNeeded()
	}

	func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
		if monthPosition == .next || monthPosition == .previous {
			calendar.setCurrentPage(date, animated: true)
		}

		setSelectedDay()
	}

	func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
		let month = calendar.currentPage

		if !dateSelected {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
				guard calendar.currentPage == month else { return }
				calendar.select(month)
				self.setSelectedDay()
			}
		}

		dateSelected = false
	}

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MyCalendarViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return selectedDayData.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: CalendarItemCell = tableView.dequeueReusableCell(withIdentifier: "CalendarItemCell", for: indexPath) as! CalendarItemCell
		let item = selectedDayData[indexPath.item]

		cell.titleLabel.text = item.name

		switch item.type {
		case .booking:
			cell.typeLabel.text = "Booking"
			cell.dotView.backgroundColor = .secondary
		case .medication:
			cell.typeLabel.text = "Medication"
			cell.dotView.backgroundColor = .tertiary
		case .diary:
			cell.typeLabel.text = "Diary record"
			cell.dotView.backgroundColor = .accent
		}

		cell.timeLabel.text = timeFormatter.string(from: item.date)

		return cell
	}

}

// MARK: - UIGestureRecognizerDelegate

extension MyCalendarViewController: UIGestureRecognizerDelegate {

	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
		if shouldBegin {
			let velocity = self.scopeGesture.velocity(in: self.view)
			switch self.calendarView.scope {
			case .month:
				return velocity.y < 0
			case .week:
				return velocity.y > 0
			@unknown default:
				fatalError()
			}
		}
		return shouldBegin
	}

}

// MARK: - Utilities

extension MyCalendarViewController {

	func setSelectedDay() {
		if let date = calendarView.selectedDate, let reservations = bookingData[date.start(of: .month)] {
			let day = date.start(of: .day)
			selectedDayData = reservations.filter({ $0.date.start(of: .day) == day })
		} else {
			selectedDayData = []
		}
		tableView.reloadData()
	}

}

// MARK: - Actions

extension MyCalendarViewController {

	@objc func setToday(_ sender: UIBarButtonItem) {
		dateSelected = true
		calendarView.select(Date())
		setSelectedDay()
	}

}
