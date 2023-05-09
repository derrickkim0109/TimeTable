//
//  TimeTableResponseDTO+Mapping.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

struct TimeTableResponseDTO: Decodable {
    struct LectureInfo: Decodable {
        let lectureCode: String

        enum CodingKeys: String, CodingKey {
            case lectureCode = "lecture_code"
        }
    }

    let items: [LectureInfo]

    enum CodingKeys: String, CodingKey {
        case items = "Items"
    }
}

extension TimeTableResponseDTO.LectureInfo {
    func toDomain() -> String {
        return lectureCode
    }
}
