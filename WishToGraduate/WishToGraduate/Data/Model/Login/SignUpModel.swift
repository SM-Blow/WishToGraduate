//
//  SignUpModel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/28.
//

import Foundation

struct SignUpModel {
    var email: String
    var password: String
    var userName: String
    var deviceToken: String
    
    func makeSignUpRequest() -> SignUpRequest {
        return SignUpRequest(email: self.email,
                             password: self.password,
                             userName: self.userName,
                             fcmDeviceToken: self.deviceToken
        )
    }
}
