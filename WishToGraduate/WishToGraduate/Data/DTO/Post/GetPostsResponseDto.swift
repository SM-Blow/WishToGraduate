//
//  GetPostsResponseDto.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/05.
//

import Foundation

struct GetPostsResponseDto: Codable {
    let postList: [Post]
}

struct Post: Codable {
    let postId: Int
    let title: String
    let borrow: Bool
    let status: Int
    let category: String
    let duedate: [Int]
}
