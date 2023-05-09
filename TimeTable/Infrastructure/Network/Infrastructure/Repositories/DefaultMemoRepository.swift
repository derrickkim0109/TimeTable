//
//  DefaultMemoRepository.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

final class DefaultMemoRepository {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultMemoRepository: MemoRepository {
    func fetchMemo(_ code: String?) async throws -> [MemoEntity] {
        let endpoint = APIEndpoints.fetchMemosInLecture(code)
        let data = try await dataTransferService.request(
            with: endpoint)

        let result = data.items.map{ $0.toDomain() }
        return result
    }

    func enrollMemo(_ memo: MemoEntity) async throws {
        let meomRequestDTO = memo.toDataForEnrollment()
        let endpoint = APIEndpoints.enrollMemo(meomRequestDTO)

        try await dataTransferService.request(
            with: endpoint)
    }

    func deleteMemo(_ memo: MemoEntity) async throws {
        let meomRequestDTO = memo.toDataForDelete()
        let endpoint = APIEndpoints.deleteMemo(meomRequestDTO)

        try await dataTransferService.request(
            with: endpoint)
    }
}
