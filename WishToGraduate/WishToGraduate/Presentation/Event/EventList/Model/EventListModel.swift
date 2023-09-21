//
//  EventListModel.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/21.
//

import Foundation

struct EventListModel {
    let title: String
    let major: String
    let timeout: String
}

extension EventListModel {
    
    static func eventListDummyData() -> [EventListModel] {
        return [
            EventListModel(title: "2023 2학기 소프트웨어학부 개강총회", major: "소프트웨어학부", timeout: "2023.09.13 18:00"),
            EventListModel(title: "2023 2학기 소프트웨어학부 개강총회", major: "소프트웨어학부", timeout: "2023.09.13 18:00"),
            EventListModel(title: "2023 2학기 소프트웨어학부 개강총회", major: "소프트웨어학부", timeout: "2023.09.13 18:00"),
            EventListModel(title: "2023 2학기 소프트웨어학부 개강총회", major: "소프트웨어학부", timeout: "2023.09.13 18:00"),
            EventListModel(title: "2023 2학기 소프트웨어학부 개강총회", major: "소프트웨어학부", timeout: "2023.09.13 18:00")
        ]
    }
}
