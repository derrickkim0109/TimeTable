//
//  memo.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import Foundation

struct Memo {
    let type: [MemoType]
    let title: String
}

enum MemoType {
    case subject
    case exam
    case study
}
