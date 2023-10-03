//
//  LoginService.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/28.
//

import Foundation
import Moya

enum LoginService {
    case signUp(param: SignUpRequest)
    case signIn
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return URLConst.signUp
        case .signIn:
            return URLConst.signIn
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .signUp(let param):
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        case .signIn:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithOutToken
    }
}
