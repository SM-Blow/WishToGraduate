//
//  ReportService.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/04.
//

import Foundation
import Moya

enum ReportService {
    case report
}

extension ReportService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }
    
    var path: String {
        return URLConst.report
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithAuthorization
    }
    
    
}
