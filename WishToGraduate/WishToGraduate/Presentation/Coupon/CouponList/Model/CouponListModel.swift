//
//  CouponListModel.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/21.
//

import Foundation

struct CouponListModel {
    let title: String
    let content: String
    let timeout: String
}

extension CouponListModel {
    
    static func couponListDummyData() -> [CouponListModel] {
        return [
            CouponListModel(title: "숙대소반", content: "현금결제 시 1,000원 할인", timeout: "2023.12.29 19:00까지"),
            CouponListModel(title: "숙대소반", content: "현금결제 시 1,000원 할인", timeout: "2023.12.29 19:00까지"),
            CouponListModel(title: "숙대소반", content: "현금결제 시 1,000원 할인", timeout: "2023.12.29 19:00까지"),
            CouponListModel(title: "숙대소반", content: "현금결제 시 1,000원 할인", timeout: "2023.12.29 19:00까지"),
            CouponListModel(title: "숙대소반", content: "현금결제 시 1,000원 할인", timeout: "2023.12.29 19:00까지")
        ]
    }
}
