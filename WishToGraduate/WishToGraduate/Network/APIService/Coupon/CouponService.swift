//
//  CouponService.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/04.
//

import Foundation
import Moya

enum CouponService {
    case couponAdd(storeName: String, content: String, dueDate: String, couponCode: String)
    case couponList
    case couponUse(id: Int)
}

extension CouponService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }
    
    var path: String {
        switch self {
        case .couponAdd:
            return URLConst.couponAdd
        case .couponList:
            return URLConst.couponList
        case .couponUse(let id):
            return URLConst.couponUse + "/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .couponAdd, .couponUse:
            return .post
        case .couponList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .couponAdd(let storeName, let content, let dueDate, let couponCode):
            return .requestParameters(
                parameters: [
                    "storeName": storeName,
                    "content": content,
                    "dueDate": dueDate,
                    "couponCode": couponCode
                ],
                encoding: JSONEncoding.default)
        case .couponList, .couponUse:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithAuthorization
    }
    
    
}
