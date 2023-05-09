//
//  DefaultMainViewModel.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

//
//  DefaultMainViewModel.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit
import JZCalendarWeekView

final class DefaultMainViewModel {
    private let fetchLecturesUseCase: FetchLecturesUseCase
    private let fetchTimeTableUseCase: FetchTimeTableUseCase
    private let fetchMemosUseCase: FetchMemosUseCase

    private var events: [CalendarEvent] = []
    lazy var eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: events)
    var lectures: [LectureEntity] = []
    var memoDictionary: [String : [MemoEntity]] = [:]

    var state: EventState?

    init(fetchLecturesUseCase: FetchLecturesUseCase,
         fetchTimeTableUseCase: FetchTimeTableUseCase,
         fetchMemosUseCase: FetchMemosUseCase) {
        self.fetchLecturesUseCase = fetchLecturesUseCase
        self.fetchTimeTableUseCase = fetchTimeTableUseCase
        self.fetchMemosUseCase = fetchMemosUseCase
    }

    private func fetchLectures(code: String) async throws -> [LectureEntity]? {
        do {
            let requestValue = FetchLecturesUseCaseRequestValue(code: code, lecture: nil)
            let result = try await fetchLecturesUseCase.execute(
                requestValue: requestValue)

            return result
        } catch (let error) {
            throw error
        }
    }

    private func fetchTimeTable() async throws -> [String] {
        do {
            let result = try await fetchTimeTableUseCase.execute()
            return result
        } catch (let error) {
            throw error
        }
    }

    private func fetchMemos(code: String?) async throws -> [MemoEntity]? {
        do {
            let result = try await fetchMemosUseCase.execute(code)
            return result
        } catch (let error) {
            throw error
        }
    }

    private func generate(_ lectureModel: LectureEntity, _ memoModel: [MemoEntity]) -> [CalendarEvent] {
        var events: [CalendarEvent] = []

        let dateFormatter = DateFormatter()
        let dayOfWeek = lectureModel.dayOfWeek
        let startTime = lectureModel.startTime
        let endTime = lectureModel.endTime

        for day in dayOfWeek {
            let startDate = day.getNextDayDate()?.update(startTime) ?? Date()
            let totalTime = dateFormatter.calculateWorkingMinutes(startTime: startTime,
                                                                  endTime: endTime)
            events.append(CalendarEvent(
                id: lectureModel.code,
                lecture: lectureModel.lecture,
                location: lectureModel.location,
                memos: memoModel,
                startDate: startDate,
                endDate: startDate.add(component: .minute, value: totalTime)))
        }

        return events
    }
}

extension DefaultMainViewModel: MainViewModel {
    func loadLectures() async {
        do {
            let timeTable = try await fetchTimeTable()

            for code in timeTable {
                guard let data = try await fetchLectures(code: code),
                      let memos = try await fetchMemos(code: code),
                      let lecture = data.first else {
                    return
                }

                lectures.append(lecture)

                memoDictionary.updateValue(memos, forKey: lecture.code)

                let sortedEvents = generate(lecture, memos)

                for event in sortedEvents {
                    events.append(event)
                }

//                if !events.isEmpty {
//                    eventsByDate = [:]
//                }
            }
        } catch (let error) {
            state = .failed(error: error.localizedDescription)
        }
    }
}
