//
//  SignInRequest.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/04.
//

import Foundation

struct SignInRequest: Codable {
    var email: String
    var password: String
    var fcmDeviceToken: String
}
