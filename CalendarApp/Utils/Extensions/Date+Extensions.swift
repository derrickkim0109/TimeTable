//
//  Date+Extensions.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import Foundation

extension Date {
    func add(component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }

    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
