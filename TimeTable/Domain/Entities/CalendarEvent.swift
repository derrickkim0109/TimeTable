//
//  CalendarEvent.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

import Foundation
import JZCalendarWeekView

final class CalendarEvent: JZBaseEvent {
    var lecture: String
    var location: String
    var memos: [MemoEntity]

    init(id: String,
         lecture: String,
         location: String,
         memos: [MemoEntity],
         startDate: Date,
         endDate: Date) {
        self.lecture = lecture
        self.location = location
        self.memos = memos

        super.init(id: id, startDate: startDate, endDate: endDate)
    }

    override func copy(with zone: NSZone?) -> Any {
        return CalendarEvent(
            id: id,
            lecture: lecture,
            location: location,
            memos: memos,
            startDate: startDate,
            endDate: endDate)
    }
}
