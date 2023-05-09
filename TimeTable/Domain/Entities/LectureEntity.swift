//
//  LectureEntity.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import Foundation

struct LectureEntity: Hashable {
    let id = UUID()
    let code: String
    let lecture: String
    let professor: String
    let location: String
    let startTime: String
    let endTime: String
    let dayOfWeek: [String]
}

extension LectureEntity {
    func convertLectureSchedule() -> String {
        return startTime + " ~ " + endTime + " | " + dayOfWeek.convertDay()
    }
}
