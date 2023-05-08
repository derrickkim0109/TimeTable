//
//  String+Extensions.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import Foundation

extension String {
    var korean: String {
        let yymm = self.split(separator: " ").map { String($0) }

        return yymm[0] + "년 " + yymm[1] + "월"
    }
}
