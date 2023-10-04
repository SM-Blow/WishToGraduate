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
            ShareListModel(title: "생리대 중형 한 개", borrow: 2, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 3, transaction: true, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: true, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 3, transaction: true, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 2, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 2, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지"),
            ShareListModel(title: "생리대 중형 한 개", borrow: 1, transaction: false, time: "2023.05.20 13:00까지")
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
    
    static func myWritingDummyData() -> [ShareListModel] {
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
