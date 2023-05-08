//
//  AnyCancellableTask.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

public protocol AnyCancellableTask {
    func cancel()
}

extension Task: AnyCancellableTask {}
