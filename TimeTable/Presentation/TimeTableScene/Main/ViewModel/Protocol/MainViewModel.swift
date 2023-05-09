//
//  MainViewModel.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import Foundation

protocol MainViewModelInput {
    func loadLectures() async
}

protocol MainViewModelOutput {
    var state: EventState? { get }
    var eventsByDate: [Date: [CalendarEvent]] { get }
    var lectures: [LectureEntity] { get }
    var memoDictionary: [String: [MemoEntity]] { get }
}

protocol MainViewModel: MainViewModelInput,
                            MainViewModelOutput {}


enum EventState {
    case failed(error: String)
}
