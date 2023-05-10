//
//  EndpointMock.swift
//  TimeTableTests
//
//  Created by Derrick kim on 2023/05/10.
//

import Foundation

struct EndpointMock: Requestable {
    var path: String
    var isFullPath: Bool = false
    var method: HTTPMethod
    var headerParameters: [String: String] = [:]
    var queryParametersEncodable: Encodable?
    var queryParameters: [String: Any] = [:]
    var bodyParametersEncodable: Encodable?
    var bodyParameters: [String: Any] = [:]
    var bodyEncoding: BodyEncoding = .stringEncodingAscii

    init(
        path: String,
        method: HTTPMethod) {
            self.path = path
            self.method = method
        }
}
