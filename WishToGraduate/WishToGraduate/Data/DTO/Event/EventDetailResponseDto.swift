//
//  EventDetailResponseDto.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/04.
//

import Foundation

struct EventDetailResponseDto: Codable {
    let currentApplyCount: Int
    let acceptCount: Int
    let title: String
    let dueDate: [Int]
    let host: String
    let content: String
}
