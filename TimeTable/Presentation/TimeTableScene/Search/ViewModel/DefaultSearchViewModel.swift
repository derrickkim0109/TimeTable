//
//  DefaultSearchViewModel.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import Foundation

final class DefaultSearchViewModel {
    private let fetchLecturesUseCase: FetchLecturesUseCase

    // MARK: OutPut
    var state: LectureState?

    init(fetchLecturesUseCase: FetchLecturesUseCase) {
        self.fetchLecturesUseCase = fetchLecturesUseCase
    }

    private func fetchLectures(code: String? = nil, lecture: String? = nil) async throws -> [LectureEntity]? {
        do {
            let requestValue = FetchLecturesUseCaseRequestValue(code: code, lecture: lecture)
            let result = try await fetchLecturesUseCase.execute(
                requestValue: requestValue)

            return result
        } catch (let error) {
            throw error
        }
    }
}

extension DefaultSearchViewModel: SearchViewModel {
    func loadLectures() async {
        do {
            guard let data = try await fetchLectures() else {
                return
            }

            self.state = .success(data: data)
        } catch (let error) {
            self.state = .failed(error: error.localizedDescription)
        }
    }

    func loadLectures(code: String?, lecture: String?) async {
        do {
            guard let data = try await fetchLectures(code: code, lecture: lecture) else {
                return
            }

            self.state = .success(data: data)
        } catch (let error) {
            self.state = .failed(error: error.localizedDescription)
        }
    }
}
