//
//  SearchViewModel.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import Foundation

protocol SearchViewModelInput {
    func loadLectures(code: String?, lecture: String?) async
    func loadLectures() async
}

protocol SearchViewModelOutput {
    var state: LectureState? { get }
}

protocol SearchViewModel: SearchViewModelInput,
                          SearchViewModelOutput { }

enum LectureState {
    case success(data: [LectureEntity])
    case failed(error: String)
}
