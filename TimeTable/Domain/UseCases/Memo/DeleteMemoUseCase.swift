//
//  DeleteMemoUseCase.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

protocol DeleteMemoUseCase {
    func execute(_ memo: MemoEntity) async throws
}

final class DefaultDeleteMemoUseCase: DeleteMemoUseCase {
    private let memoRepository: MemoRepository

    init(memoRepository: MemoRepository) {
        self.memoRepository = memoRepository
    }

    func execute(_ memo: MemoEntity) async throws {
        return try await memoRepository.deleteMemo(memo)
    }
}
