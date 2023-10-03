//
//  Model.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/04.
//

import Foundation

struct CouponListResponseDto: Codable {
    let couponList: [Coupon]
}

struct Coupon: Codable {
    let couponId: Int
    let storeName: String
    let content: String
    let dueDate: [Int]
}
