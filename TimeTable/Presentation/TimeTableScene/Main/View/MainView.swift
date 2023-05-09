//
//  MainView.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit
import JZCalendarWeekView

final class MainView: BaseView {
    let navigationBarView = MainNavigationBarView()

    let mainHeaderView = MainHeaderView()

    let calendarView: CalendarView = {
        let calendarView = CalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.setupCalendar(numOfDays: 5,
                                   setDate: Date(),
                                   allEvents: [:],
                                   scrollType: .pageScroll)
        return calendarView
    }()

    private let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        [navigationBarView,
         mainHeaderView,
         borderView,
         calendarView].forEach { addSubview($0) }
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            mainHeaderView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            mainHeaderView.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor),
            mainHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            borderView.bottomAnchor.constraint(equalTo: calendarView.topAnchor),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 0.5)
        ])

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: mainHeaderView.bottomAnchor),
            calendarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
