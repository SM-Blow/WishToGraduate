//
//  MyPageResponse.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/25.
//

struct MyPageResponse: Codable {
    let userId: Int
    let nickname: String
    let seed: Int
    let posts: [Posts]
    let scraps: [Scraps]
}

struct Posts: Codable {
    let postId: Int
    let title: String
    let borrow: Bool
    let dueDate: String
    let status: Bool
    let category: String
}

struct Scraps: Codable {
    let postId: Int
    let title: String
    let borrow: Bool
    let dueDate: String
    let status: Bool
    let category: String
}
