//
//  FetchTimeTableUseCase.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

protocol FetchTimeTableUseCase {
    func execute() async throws -> [String]
}

final class DefaultFetchTimeTableUseCase: FetchTimeTableUseCase {
    private let timeTableRepository: TimeTableRepository

    init(timeTableRepository: TimeTableRepository) {
        self.timeTableRepository = timeTableRepository
    }

    func execute() async throws -> [String] {
        return try await timeTableRepository.fetchTimeTable()
    }
}
