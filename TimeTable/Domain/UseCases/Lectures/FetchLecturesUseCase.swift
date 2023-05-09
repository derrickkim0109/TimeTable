//
//  FetchLecturesUseCase.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

protocol FetchLecturesUseCase {
    func execute(requestValue: FetchLecturesUseCaseRequestValue?) async throws -> [LectureEntity]
}

final class DefaultFetchLecturesUseCase: FetchLecturesUseCase {
    private let lecturesRepository: LecturesRepository

    init(lecturesRepository: LecturesRepository) {
        self.lecturesRepository = lecturesRepository
    }

    func execute(requestValue: FetchLecturesUseCaseRequestValue?) async throws -> [LectureEntity] {
        return try await lecturesRepository.fetchLectures(
            requestValue?.code,
            requestValue?.lecture)
    }
}

struct FetchLecturesUseCaseRequestValue {
    let code: String?
    let lecture: String?
}
