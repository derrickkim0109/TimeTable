//
//  TimeTableRepository.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

protocol TimeTableRepository {
    func fetchTimeTable() async throws -> [String]
    func enrollTimeTable(_ code: String) async throws
    func deleteTimeTable(_ code: String) async throws
}
