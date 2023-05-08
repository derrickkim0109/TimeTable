//
//  CalendarViewModel.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit
import JZCalendarWeekView

final class CalendarViewModel {
    private let firstDate = Date().add(component: .hour, value: 1)
    private let secondDate = Date().add(component: .day, value: 1)
    private let thirdDate = Date().add(component: .day, value: 2)

    lazy var events = [CalendarEvent(id: "0", title: "웹 프로그래밍", lecture: "강의실 302", memoTitles: [Memo(type: .study, title: "제목 텍스트"),Memo(type: .exam, title: "제목 텍스트"), Memo(type: .subject, title: "제목 텍스트")], startDate: firstDate, endDate: firstDate.add(component: .hour, value: 3)),
                       CalendarEvent(id: "1", title: "자료구조", lecture: "강의실 302", memoTitles: [Memo(type: .exam, title: "시험 텍스트"),Memo(type: .study, title: "스터디 텍스트"),Memo(type: .subject, title: "과제 텍스트")], startDate: secondDate, endDate: secondDate.add(component: .hour, value: 5))]

    lazy var eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: events)
}
