//
//  LectureDetailViewModel.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

protocol LectureDetailViewModelInput {
    func didTapEnrollTimeTableButton(_ code: String) async
    func didTapDeleteTimeTableButton(_ code: String) async
    func didTapDeleteMemoButton(_ memoEntity: MemoEntity) async
    func loadMemos(_ code: String) async
}

protocol LectureDetailViewModelOutput {
    var state: TimeTableState? { get }
    var memoState: MemoState? { get }
}

protocol LectureDetailViewModel: LectureDetailViewModelInput,
                                 LectureDetailViewModelOutput { }

enum TimeTableState {
    case success
    case failed(error: String)
}

enum MemoState {
    case success(memos: [MemoEntity])
    case failed(error: String)
}
