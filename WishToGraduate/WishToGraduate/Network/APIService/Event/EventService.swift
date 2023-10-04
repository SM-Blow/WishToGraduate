//
//  EventService.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/04.
//

import Foundation
import Moya

enum EventService {
    case addEvent(acceptCount: Int, content: String, dueDate: String, host: String, title: String)
    case getEventList
    case getEventDetail(eventId: Int)
    case applyEvent(eventId: Int)
}

extension EventService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }
    
    var path: String {
        switch self {
        case .addEvent:
            return URLConst.event
        case .getEventList:
            return URLConst.eventList
        case .getEventDetail(let eventId):
            return URLConst.event + "/\(eventId)"
        case .applyEvent(let eventId):
            return URLConst.event + "/\(eventId)" + "/apply"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getEventList, .getEventDetail:
            return .get
        case .addEvent, .applyEvent:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .addEvent(let acceptCount, let content, let dueDate, let host, let title):
            return .requestParameters(
                parameters: ["acceptCount": acceptCount,
                             "content": content,
                             "dueDate": dueDate,
                             "host": host,
                             "title": title
                            ],
                encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithAuthorization
    }
}
