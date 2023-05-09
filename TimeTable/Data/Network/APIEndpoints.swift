//
//  APIEndpoints.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

struct APIEndpoints {
    static func fetchLectures(
        _ code: String? = nil,
        _ lecture: String? = nil) -> Endpoint<LecturesResponseDTO> {
            let codeParameter = ["code": code ?? ""]
            let lectureParameter = ["lecture": lecture ?? ""]

            var queryParameter: [String: Any] = [:]

            if code != nil {
                queryParameter = codeParameter as [String : Any]
            } else if lecture != nil {
                queryParameter = lectureParameter as [String : Any]
            }

            return Endpoint(
                path: HTTPPath.lectures.value,
                method: .get,
                queryParameters: queryParameter as [String : Any])
        }

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
