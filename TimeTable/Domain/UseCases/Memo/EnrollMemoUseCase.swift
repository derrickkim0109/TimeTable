//
//  EnrollMemoUseCase.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

protocol EnrollMemoUseCase {
    func execute(_ memo: MemoEntity) async throws
}

final class DefaultEnrollMemoUseCase: EnrollMemoUseCase {
    private let memoRepository: MemoRepository

    init(memoRepository: MemoRepository) {
        self.memoRepository = memoRepository
    }

    func execute(_ memo: MemoEntity) async throws {
        return try await memoRepository.enrollMemo(memo)
    }
}
