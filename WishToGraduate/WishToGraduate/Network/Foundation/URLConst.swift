//
//  URLConst.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/24.
//

import Foundation

public enum URLConst {
    
    // MARK: - Base URL
    
    static let baseURL = Config.baseURL
    
    // MARK: - URL Path
    
    // 로그인
    static let signUp = "/api/v1/auth/signup"
    static let signIn = "/api/v1/auth/login"
    static let socialLogin = "/api/v1/social/login"
    static let socialLogout = "/api/v1/social/logout"
    static let socialRefresh = "/api/v1/social/refresh"
    
    // 이미지
    static let ImageUpload = "/api/v1/s3/image?fileName={imageName}"
    
    // 게시글
    static let postScraps = "/api/v1/post/scraps"
    static let post = "/api/v1/post"
    static let postPostId = "/api/v1/post/{postId}"
    static let postCategory = "/api/v1/posts?category={category}"
    static let postKeyword = "/api/v1/post?keyword={ketword}"
    static let postScrap = "/api/v1/post/scrap"
    
    // 유저
    static let userHome = "/api/v1/user/home"
    static let userMypage = "/api/v1/user/my"
    static let report = "/api/v1/report"
    
    // 쿠폰 이벤트
    static let couponList = "/api/v1/coupon/list"
    static let coupon = "/api/v1/coupon"
    static let couponUsedList = "/api/v1/coupon/used-list"
    
    // 행사
    static let eventList = "/api/v1/event/list"
    static let event = "/api/v1/event"
    static let eventMy = "/api/v1/event/my"
    
    // 푸시알림
    static let notification = "/api/v1/notification"
    
    static let bearer = "Bearer "
}
