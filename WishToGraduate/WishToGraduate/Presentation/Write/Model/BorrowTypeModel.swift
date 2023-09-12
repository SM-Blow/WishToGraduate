//
//  BorrowTypeModel.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/13.
//

import Foundation

struct BorrowTypeModel {
    let type: String
}

extension BorrowTypeModel {
    static func BorrowTypeDummyData() -> [BorrowTypeModel] {
        return [
            BorrowTypeModel(type: "빌려요"),
            BorrowTypeModel(type: "빌려줄게요")
        ]
    }
}
