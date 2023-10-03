//
//  SignInModel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/04.
//

import Foundation

struct SignInModel {
    var email: String
    var password: String
    var fcmDeviceToken: String
    
    func makeSignInRequest() -> SignInRequest {
        return SignInRequest(email: self.email,
                             password: self.password,
                             fcmDeviceToken: self.fcmDeviceToken
        )
    }
}
