//
//  ReportService.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/04.
//

import Foundation
import Moya

enum ReportService {
    case report(param: ReportRequest)
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
        switch self {
        case .report(let param):
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithAuthorization
    }
    
    
}
