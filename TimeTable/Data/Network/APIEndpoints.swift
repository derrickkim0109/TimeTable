//
//  APIEndpoints.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

struct APIEndpoints {
    static func fetchTiemTable() -> Endpoint<TimeTableResponseDTO> {
        let queryParameter = ["user_key": AppConfiguration.userToken]

        return Endpoint(
            path: HTTPPath.timeTable.value,
            method: .get,
            queryParameters: queryParameter)
    }

    static func enrollTimeTable(_ code: String) -> Endpoint<()> {
        let bodyParameters = ["user_key": AppConfiguration.userToken,
                              "code": code]

        return Endpoint(
            path: HTTPPath.timeTable.value,
            method: .post,
            bodyParameters: bodyParameters)
    }

    static func deleteTimeTable(_ code: String) -> Endpoint<()> {
        let bodyParameters = ["user_key": AppConfiguration.userToken,
                              "code": code]

        return Endpoint(
            path: HTTPPath.timeTable.value,
            method: .delete,
            bodyParameters: bodyParameters)
    }
}
