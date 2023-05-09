//
//  Array+Extensions.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import Foundation

extension Array {
    func convertDay() -> String {
        let addedParenthesesDay = self.map ({ "(\($0))"}).reduce("", { $0 + $1 })
        let modifiedWeekdays = addedParenthesesDay.replacingOccurrences(of: ")(", with: "), (")

        return modifiedWeekdays
    }
}


