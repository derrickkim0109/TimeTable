//
//  DeleteTimeTableUseCase.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

protocol DeleteTimeTableUseCase {
    func execute(_ code: String) async throws
}

final class DefaultDeleteTimeTableUseCase: DeleteTimeTableUseCase {
    private let timeTableRepository: TimeTableRepository

    init(timeTableRepository: TimeTableRepository) {
        self.timeTableRepository = timeTableRepository
    }

    func execute(_ code: String) async throws {
        return try await timeTableRepository.deleteTimeTable(code)
    }
}
