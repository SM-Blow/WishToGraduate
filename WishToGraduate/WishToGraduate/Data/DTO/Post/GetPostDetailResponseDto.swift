//
//  GetPostDetailResponseDto.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/05.
//

import Foundation

struct GetPostDetailResponseDto: Codable {
    let nickname: String
    let postId: Int
    let duedate: [Int]
    let title: String
    let borrow: Bool
    let status: Int
    let content: String
    let currentScrapStatus: Bool
}
