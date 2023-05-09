//
//  DefaultLectureDetailViewModel.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import Foundation

final class DefaultLectureDetailViewModel {
    private let enrollTimeTableUseCase: EnrollTimeTableUseCase
    private let deleteTimeTableUseCase: DeleteTimeTableUseCase
    private let fetchMemosUseCase: FetchMemosUseCase
    private let deleteMemoUseCase: DeleteMemoUseCase

    // MARK: OutPut
    var state: TimeTableState?
    var memoState: MemoState?

    init(enrollTimeTableUseCase: EnrollTimeTableUseCase,
         deleteTimeTableUseCase: DeleteTimeTableUseCase,
         fetchMemosUseCase: FetchMemosUseCase,
         deleteMemoUseCase: DeleteMemoUseCase) {
        self.enrollTimeTableUseCase = enrollTimeTableUseCase
        self.deleteTimeTableUseCase = deleteTimeTableUseCase
        self.fetchMemosUseCase = fetchMemosUseCase
        self.deleteMemoUseCase = deleteMemoUseCase
    }

    private func enrollTimeTable(code: String) async throws {
        do {
            try await enrollTimeTableUseCase.execute(code)
        } catch (let error) {
            throw error
        }
    }

    private func deleteTimeTable(code: String) async throws {
        do {
            try await deleteTimeTableUseCase.execute(code)
        } catch (let error) {
            throw error
        }
    }

    private func deleteMemo(memoEntity: MemoEntity) async throws {
        do {
            try await deleteMemoUseCase.execute(memoEntity)
        } catch (let error) {
            throw error
        }
    }

    private func fetchMemos(code: String) async throws -> [MemoEntity] {
        do {
            let data = try await fetchMemosUseCase.execute(code)
            return data
        } catch (let error) {
            throw error
        }
    }
}

extension DefaultLectureDetailViewModel: LectureDetailViewModel {
    func didTapEnrollTimeTableButton(_ code: String) async {
        do {
            try await enrollTimeTable(code: code)
            self.state = .success
        } catch (let error) {
            self.state = .failed(error: error.localizedDescription)
        }
    }

    func didTapDeleteTimeTableButton(_ code: String) async {
        do {
            try await deleteTimeTable(code: code)
            self.state = .success
        } catch (let error) {
            self.state = .failed(error: error.localizedDescription)
        }
    }

    func didTapDeleteMemoButton(_ memoEntity: MemoEntity) async {
        do {
            try await deleteMemo(memoEntity: memoEntity)
            self.state = .success
        } catch (let error) {
            self.state = .failed(error: error.localizedDescription)
        }
    }

    func loadMemos(_ code: String) async {
        do {
            let data = try await fetchMemos(code: code)
            self.memoState = .success(memos: data)
        } catch (let error) {
            self.memoState = .failed(error: error.localizedDescription)
        }
    }
}
