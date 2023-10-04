//
//  APIConst.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/04.
//

import Foundation

enum NetworkHeaderKey: String {
    case deviceToken = "deviceToken"
    case accessToken = "accesstoken"
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

enum APIConstants {
    
    static let accept: String = "Accept"
    static let auth: String = "x-auth-token"
    static let applicationJSON = "application/json"
    static var deviceToken: String = ""
    static var jwtToken: String = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNiIsImV4cCI6MTY5NjQ0MDc4OH0.r7Y5T2Lre-dnYjtQALWYLrLb75PQQnKWPItE8OY6hY4"
    static var userID: Int = 0
    
    //MARK: - Header
    
    static var headerWithOutToken: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON
        ]
    }
    
    static var headerWithDeviceToken: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: APIConstants.jwtToken
        ]
    }
    
    static var headerWithAuthorization: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: APIConstants.jwtToken
        ]
    }
    
    static var headerWithRefresh: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: APIConstants.jwtToken
        ]
    }
}
