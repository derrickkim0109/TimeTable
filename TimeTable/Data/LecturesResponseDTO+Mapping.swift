//
//  LecturesResponseDTO+Mapping.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import Foundation

struct LecturesResponseDTO: Decodable {
    struct LectureInfo: Decodable {
        let code: String
        let lecture: String
        let professor: String
        let location: String
        let startTime: String
        let endTime: String
        let dayOfWeek: [String]

        enum CodingKeys: String, CodingKey {
            case code
            case lecture
            case professor
            case location
            case startTime = "start_time"
            case endTime = "end_time"
            case dayOfWeek = "dayofweek"
        }
    }

    let items: [LectureInfo]

    enum CodingKeys: String, CodingKey {
        case items = "Items"
    }
}

extension LecturesResponseDTO.LectureInfo {
    func toDomain() -> LectureEntity {
        return LectureEntity(
            code: code,
            lecture: lecture,
            professor: professor,
            location: location,
            startTime: startTime,
            endTime: endTime,
            dayOfWeek: dayOfWeek)
    }
}

