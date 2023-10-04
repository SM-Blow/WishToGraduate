//
//  GetScrapPostResponseDto.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/05.
//

import Foundation

struct GetScrapPostResponseDto: Codable {
    let postscrapsList: [ScrapPost]
}

struct ScrapPost: Codable {
    let title: String
    let borrow: Bool
    let status: Int
    let duedate: [Int]
    let isScraped: Bool
}
