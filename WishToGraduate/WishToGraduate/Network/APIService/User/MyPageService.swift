//
//  MyPageService.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/25.
//

import Foundation
import Moya

enum MyPageService {
    case myPage
}

extension MyPageService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }
    
    var path: String {
        return URLConst.userMypage
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
