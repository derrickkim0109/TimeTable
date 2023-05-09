//
//  MemoResponseDTO+Mapping.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import Foundation

struct MemoResponseDTO: Decodable {
    struct MemoInfo: Decodable {
        let userKey: String
        let lectureCode: String
        let type: String
        let title: String
        let description: String
        let date: String

        enum CodingKeys: String, CodingKey {
            case userKey = "user_key"
            case lectureCode = "lecture_code"
            case type
            case title
            case description
            case date
        }
    }

    let items: [MemoInfo]

    enum CodingKeys: String, CodingKey {
        case items = "Items"
    }
}

extension MemoResponseDTO.MemoInfo {
    func toDomain() -> MemoEntity {
        let type = MemoType(rawValue: type) ?? .exam

        return MemoEntity(
            userKey: userKey,
            lectureCode: lectureCode,
            type: type,
            title: title,
            description: description,
            date: date)
    }
}
