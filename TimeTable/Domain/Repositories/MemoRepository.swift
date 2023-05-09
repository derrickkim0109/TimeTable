//
//  MemoRepository.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

protocol MemoRepository {
    func fetchMemo(_ code: String?) async throws -> [MemoEntity]
    func enrollMemo(_ memo: MemoEntity) async throws
    func deleteMemo(_ memo: MemoEntity) async throws
}
