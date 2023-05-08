//
//  CalendarEvent.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import Foundation
import JZCalendarWeekView

final class CalendarEvent: JZBaseEvent {
    var title: String
    var lecture: String
    var memos: [Memo]

    init(id: String,
         title: String,
         lecture: String,
         memoTitles: [Memo],
         startDate: Date,
         endDate: Date) {
        self.title = title
        self.lecture = lecture
        self.memos = memoTitles

        super.init(id: id, startDate: startDate, endDate: endDate)
    }

    override func copy(with zone: NSZone?) -> Any {
        return CalendarEvent(
            id: id,
            title: title,
            lecture: lecture,
            memoTitles: memos,
            startDate: startDate,
            endDate: endDate)
    }
}
