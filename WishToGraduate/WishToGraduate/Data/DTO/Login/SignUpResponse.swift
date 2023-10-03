//
//  SignUpResponse.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/28.
//

import Foundation

struct SignUpResponse: Codable {
    let id: Int
    let userName: String
    let accessToken: String
}
