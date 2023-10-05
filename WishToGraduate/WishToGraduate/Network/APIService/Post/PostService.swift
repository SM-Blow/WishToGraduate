//
//  PostService.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/05.
//

import Foundation
import Moya

enum PostService {
    case getAllPosts                                    // 게시물 전체 조회
    case getPostByCategory(category: String)         // 게시물 카테고리별 조회
    case getScrapPost                                   // 스크랩한 게시물 조회
    case postScrap(currentScrapStatus: Bool, targetPostId: Int)                  // 게시물 스크랩
    case postChangeStatus(postId: Int, status: Bool)                             // 게시물 상태 변경
    case addPost(borrow: Bool, category: String, content: String, duedate: String, photoUrl: String, title: String)
    case getSearch(keyword: String)
}

extension PostService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getAllPosts, .addPost:
            return URLConst.post
        case .getPostByCategory:
            return URLConst.postCategory
        case .getScrapPost:
            return URLConst.postScraps
        case .postScrap:
            return URLConst.postScrap
        case .postChangeStatus:
            return URLConst.postStatus
        case .getSearch:
            return URLConst.postKeyword
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllPosts, .getScrapPost, .getPostByCategory, .getSearch:
            return .get
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPostByCategory(let category):
            let param: [String: Any] = ["category": category]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .postChangeStatus(let postId, let status):
            return .requestParameters(
                parameters: ["postId": postId, "status": status],
                encoding: JSONEncoding.default
            )
        case .postScrap(let currentScrapStatus, let targetPostId):
            return .requestParameters(
                parameters: ["currentScrapStatus": currentScrapStatus,
                             "targetPostId": targetPostId],
                encoding: JSONEncoding.default)
        case .addPost(let borrow, let category, let content, let duedate, let photoUrl, let title):
            return .requestParameters(
                parameters: ["borrow": borrow, "category": category, "content": content, "duedate": duedate,
                             "photoUrl": photoUrl, "title": title],
                encoding: JSONEncoding.default)
        case .getSearch(let keyword):
            let param: [String: Any] = ["keyword": keyword]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithAuthorization
    }
}
