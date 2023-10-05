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
    let posts: [Post]
    let scraps: [Post]
}
