//
//  memo.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import Foundation

struct Memo {
    let type: MemoType
    let title: String
}

enum MemoType: String {
    case subject = "list.clipboard"
    case exam = "doc.text.image"
    case study = "books.vertical"

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
}
