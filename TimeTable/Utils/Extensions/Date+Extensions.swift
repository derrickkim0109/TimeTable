//
//  Date+Extensions.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

import Foundation

extension Date {
    var formattedDateString: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }

    func add(component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }

    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    func update(_ time: String) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year,
                                                  .month,
                                                  .day,
                                                  .hour,
                                                  .minute,
                                                  .second], from: self)

        let splitedTime = time.split(separator: ":").map { Int(String($0)) ?? 0 }
        let hour = splitedTime[0]
        let minute = splitedTime[1]

        components.hour = hour
        components.minute = minute
        components.second = 0

        let updatedDate = calendar.date(from: components) ?? Date()
        return updatedDate
    }
}

extension DateFormatter {
    func calculateWorkingMinutes(startTime: String, endTime: String) -> Int {
        self.dateFormat = "HH:mm"

        guard let startDate = self.date(from: startTime),
              let endDate = self.date(from: endTime) else {
            return 0
        }

        let calendar = Calendar.current
        let currentDate = Date()
        var startComponents = calendar.dateComponents([.hour, .minute], from: currentDate)
        var endComponents = calendar.dateComponents([.hour, .minute], from: currentDate)

        let startHour = calendar.component(.hour, from: startDate)
        let startMinute = calendar.component(.minute, from: startDate)
        startComponents.hour = startHour
        startComponents.minute = startMinute

        let endHour = calendar.component(.hour, from: endDate)
        let endMinute = calendar.component(.minute, from: endDate)
        endComponents.hour = endHour
        endComponents.minute = endMinute

        if endDate < startDate {
            endComponents.hour? += 24
        }

        guard let updatedStartDate = calendar.date(from: startComponents),
              let updatedEndDate = calendar.date(from: endComponents) else {
            return 0
        }

        let difference = calendar.dateComponents([.minute], from: updatedStartDate, to: updatedEndDate)
        guard let workingMinutes = difference.minute else {
            return 0
        }

        return workingMinutes
    }
}
