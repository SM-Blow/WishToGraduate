//
//  SignUpRequest.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/28.
//

import Foundation

struct SignUpRequest: Codable {
    var email: String
    var password: String
    var userName: String
    var fcmDeviceToken: String
}
