//
//  PostScrapResponseDto.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/05.
//

import Foundation

struct PostScrapResponseDto: Codable {
    let targetPostId: Int
    let currentScrapStatus: Bool
}
