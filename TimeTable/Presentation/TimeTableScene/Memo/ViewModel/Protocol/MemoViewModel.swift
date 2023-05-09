//
//  MemoViewModel.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

import Foundation

protocol MemoViewModelInput {
    func didTapEnrollMemo(_ memoEntity: MemoEntity) async
}

protocol MemoViewModelOutput {
    var memoState: MemoEnrollmentState? { get }
}

protocol MemoViewModel: MemoViewModelInput,
                        MemoViewModelOutput { }

enum MemoEnrollmentState {
    case success
    case failed(error: String)
}
