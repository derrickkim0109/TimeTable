//
//  NetworkConfigurableMock.swift
//  TimeTableTests
//
//  Created by Derrick kim on 2023/05/10.
//

import Foundation

struct NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(
        string: "https://k03c8j1o5a.execute-api.ap-northeast-2.amazonaws.com/v1/programmers")!

    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
