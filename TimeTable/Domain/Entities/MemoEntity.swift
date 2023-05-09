//
//  memo.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

import Foundation

struct MemoEntity: Hashable {
    let id = UUID()
    let userKey: String
    let lectureCode: String
    let type: MemoType
    let title: String
    let description: String
    let date: String
}

extension MemoEntity {
    func toDataForEnrollment() -> MemoRequestDTO {
        return MemoRequestDTO(
            userKey: userKey,
            code: lectureCode,
            type: type.rawValue,
            title: title,
            description: description,
            date: date)
    }

    func toDataForDelete() -> MemoRequestDTO {
        return MemoRequestDTO(
            userKey: userKey,
            code: lectureCode,
            type: type.rawValue,
            title: nil,
            description: nil,
            date: nil)
    }
}

enum MemoType: String {
    case subject = "SUBJECT"
    case exam = "EXAM"
    case study = "STUDY"

    var korean: String {
        switch self {
        case .subject:
            return "과제"
        case .exam:
            return "시험"
        case .study:
            return "스터디"
        }
    }

    var imageName: String {
        switch self {
        case .subject:
            return "list.clipboard"
        case .exam:
            return "doc.text.image"
        case .study:
            return "books.vertical"
        }
    }
}
