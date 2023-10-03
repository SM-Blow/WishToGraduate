//
//  EventListResponseDto.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/04.
//

import Foundation

struct EventListResponseDto: Codable {
    let eventId: Int
    let title: String
    let dueDate: [Int]
    let host: String
}
