//
//  SearchResponse.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/05.
//

import Foundation

struct SearchResponse: Codable {
    let borrow: Bool
    let category: String
    let content: String
    let duedate: String
    let title: String
}
