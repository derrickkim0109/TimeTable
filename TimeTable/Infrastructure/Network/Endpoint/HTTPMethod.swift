//
//  HTTPMethod.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum HTTPPath {
    case lectures
    case timeTable
    case memo

    var value: String {
        switch self {
        case .lectures:
            return "/lectures"
        case .timeTable:
            return "/timetable"
        case .memo:
            return "/memo"
        }
    }
}

enum HTTPHeaderField {
    case json(key: String)

    var header: [String: String] {
        switch self {
        case .json(let key):
            return [HTTPHeaderField.apiKey: key,
                    HTTPHeaderField.contentType: HTTPHeaderField.applicationJSON]
        }
    }

    private static let apiKey = "x-api-key"
    private static let applicationJSON = "application/json"
    private static let contentType = "Content-Type"
}
