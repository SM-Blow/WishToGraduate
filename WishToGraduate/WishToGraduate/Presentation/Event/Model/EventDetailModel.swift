//
//  EventDetailModel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/19.
//

import UIKit

struct EventDetailModel {
    let userName: String
    let date: String
    let title: String
    let applicationPerson: String
    let content: String
}

extension EventDetailModel {
    
    static func eventDetailModelDummyData() -> EventDetailModel {
        return EventDetailModel(
            userName: "소프트웨어학부",
            date: "2023.05.20 13:30",
            title: "2023 2학기 소프트웨어 개강총회",
            applicationPerson: "161/200",
            content: """
                    안녕하세요. 소프트웨어학부 학생회 BLOW 입니다.
                    개강총회 안내글이 이어집니다.
                    개강총회 안내글이 이어집니다.
                    개강총회 안내글이 이어집니다.
                    개강총회 안내글이 이어집니다.
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    ㅇ
                    """
        )
    }
}
