//
//  LecturesRepository.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

protocol LecturesRepository {
    func fetchLectures(_ code: String?, _ lecture: String?) async throws -> [LectureEntity]
}
