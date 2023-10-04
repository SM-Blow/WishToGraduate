//
//  EventDetailResponseDto.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/04.
//

import Foundation

struct EventDetailResponseDto: Codable {
    let host: String
    let dueDate: [Int]
    let title: String
    let acceptCount: Int
    let currentApplyCount: Int
    let content: String
}
