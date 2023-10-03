//
//  SignUpRequest.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/28.
//

import Foundation

struct SignUpRequest: Codable {
    let email: String
    let password: String
    let userName: String
    let fcmDeviceToken: String
}
