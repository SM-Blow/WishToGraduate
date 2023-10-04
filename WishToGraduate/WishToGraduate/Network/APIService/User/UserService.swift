//
//  MyPageService.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/25.
//

import Foundation
import Moya

enum UserService {
    case home
    case myPage
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }
    
    var path: String {
        switch self {
        case .home:
            return URLConst.userHome
        case .myPage:
            return URLConst.userMypage
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithAuthorization
    }
}
