//
//  String+Extensions.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

import Foundation

extension String {
    var korean: String {
        let yymm = self.split(separator: " ").map { String($0) }
        return yymm[0] + "년 " + yymm[1] + "월"
    }

    func getNextDayDate() -> Date? {
        let weekdays = ["월", "화", "수", "목", "금", "토", "일"]
        let calendar = Calendar.current

        let currentDate = Date()
        let currentWeekday = calendar.component(.weekday, from: currentDate)

        if let currentIndex = weekdays.firstIndex(of: self) {
            var daysToAdd = currentIndex - currentWeekday

            if daysToAdd <= 0 {
                daysToAdd += 7
            }

            let nextDate = calendar.date(byAdding: .day, value: daysToAdd, to: currentDate)

            return nextDate
        }

        return nil
    }
}
