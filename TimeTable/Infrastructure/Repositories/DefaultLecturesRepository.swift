//
//  DefaultLecturesRepository.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

final class DefaultLecturesRepository {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultLecturesRepository: LecturesRepository {
    func fetchLectures(_ code: String?, _ lecture: String?) async throws -> [LectureEntity] {
        let endpoint = APIEndpoints.fetchLectures(code, lecture)
        let data = try await dataTransferService.request(
            with: endpoint)

        let result = data.items.map{ $0.toDomain() }

        return result
    }
}
