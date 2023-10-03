//
//  SignInRequest.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/04.
//

import Foundation

struct SignInRequest: Codable {
    let email: String
    let password: String
    let fcmDeviceToken: String
}
