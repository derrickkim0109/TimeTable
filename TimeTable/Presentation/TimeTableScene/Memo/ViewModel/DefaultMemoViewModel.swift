//
//  DefaultMemoViewModel.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

import Foundation

final class DefaultMemoViewModel {
    private let enrollMemoUseCase: EnrollMemoUseCase

    // MARK: OutPut
    var memoState: MemoEnrollmentState?

    init(enrollMemoUseCase: EnrollMemoUseCase) {
        self.enrollMemoUseCase = enrollMemoUseCase
    }

    private func enrollMemo(memoEntity: MemoEntity) async throws {
        do {
            try await enrollMemoUseCase.execute(memoEntity)
        } catch (let error) {
            throw error
        }
    }
}

extension DefaultMemoViewModel: MemoViewModel {
    func didTapEnrollMemo(_ memoEntity: MemoEntity) async {
        do {
            try await enrollMemo(memoEntity: memoEntity)
            self.memoState = .success
        } catch (let error) {
            self.memoState = .failed(error: error.localizedDescription)
        }
    }
}
