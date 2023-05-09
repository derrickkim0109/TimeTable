//
//  MemoRequestDTO+Mapping.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

struct MemoRequestDTO: Encodable {
    let userKey: String
    let code: String
    let type: String
    let title: String?
    let description: String?
    let date: String?

    enum CodingKeys: String, CodingKey {
        case userKey = "user_key"
        case code
        case type
        case title
        case description
        case date
    }
}
