//
//  ConnectionError.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError,
              error.isInternetConnectionError else {
            return false
        }

        return true
    }
}
