//
//  AppConfiguration.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import Foundation

final class AppConfiguration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(
            forInfoDictionaryKey: "APIKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(
            forInfoDictionaryKey: "APIBaseURL") as? String else {
            fatalError("APIBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()

    static let userToken: String = {
        guard let userToken = Bundle.main.object(
            forInfoDictionaryKey: "UserToken") as? String else {
            fatalError("UserToken must not be empty in plist")
        }
        return userToken
    }()
}
