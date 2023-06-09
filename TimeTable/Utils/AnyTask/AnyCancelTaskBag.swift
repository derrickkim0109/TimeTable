//
//  AnyCancelTaskBag.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

final class AnyCancelTaskBag {
    private var tasks: [any AnyCancellableTask] = []

    init() {}

    func add(
        task: any AnyCancellableTask) {
        tasks.append(task)
    }

    private func cancel() {
        tasks.forEach { $0.cancel() }
        tasks.removeAll()
    }

    deinit {
        cancel()
    }
}

extension Task {
    func store(
        in bag: AnyCancelTaskBag) {
        bag.add(task: self)
    }
}
