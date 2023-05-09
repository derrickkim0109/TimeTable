//
//  DefaultTimeTableRepository.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

final class DefaultTimeTableRepository {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultTimeTableRepository: TimeTableRepository {
    func fetchTimeTable() async throws -> [String] {
        let endpoint = APIEndpoints.fetchTiemTable()
        let data = try await dataTransferService.request(
            with: endpoint)

        let result = data.items.map{ $0.toDomain() }
        return result
    }

    func enrollTimeTable(_ code: String) async throws {
        let endpoint = APIEndpoints.enrollTimeTable(code)

        try await dataTransferService.request(
            with: endpoint)
    }

    func deleteTimeTable(_ code: String) async throws {
        let endpoint = APIEndpoints.deleteTimeTable(code)

        try await dataTransferService.request(
            with: endpoint)
    }
}
