//
//  HomeListModel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/17.
//

import UIKit

struct ShareListModel {
    let title: String
    let borrow: Int
    let transaction: Bool
    let time: String
}

extension ShareListModel {
    
    static func shareListModelDummyData() -> [ShareListModel] {
        return [
            ShareListModel(title: "비판적사고와토론 책", borrow: 1, transaction: true, time: "2023.10.06 13:30까지"),
            ShareListModel(title: "명신관 공차 배달 시켜먹을 분", borrow: 3, transaction: false, time: "2023.10.06 10:00까지"),
            ShareListModel(title: "아이폰 충전기", borrow: 2, transaction: true, time: "빌려줄게요"),
            ShareListModel(title: "학교 앞 바선생 잡아주실 분", borrow: 3, transaction: false, time: "2023.10.05 23:59까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: true, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "프로그래밍 언어론 교재 빌려주실 분", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "아이패드 충전기", borrow: 2, transaction: true, time: "2023.11.01 21:00까지"),
            ShareListModel(title: "같이 마라탕 시켜드실 분", borrow: 3, transaction: false, time: "2023.10.20 13:00까지"),
            ShareListModel(title: "타이레놀 나눔해요", borrow: 2, transaction: true, time: "2023.10.21 16:00까지"),
            ShareListModel(title: "공학영어 책", borrow: 2, transaction: false, time: "2023.10.21 16:00까지")
        ]
    }
    
    static func fillDummyData() -> [ShareListModel] {
        return [
            ShareListModel(title: "타이레놀", borrow: 2, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "타이레놀", borrow: 1, transaction: true, time: "2023.05.20 13:00까지")
        ]
    }
    
    static func emptyDummyData() -> [ShareListModel] {
        return []
    }
    
    static func myPostDummyData() -> [ShareListModel] {
        return [
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지")
        ]
    }
    
    static func myScrapDummyData() -> [ShareListModel] {
        return [
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지")
        ]
    }
}
