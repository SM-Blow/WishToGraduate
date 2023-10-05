//
//  ChatListModel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/06.
//

import Foundation

struct ChatListModel {
    let nickName: String
    let messagePreview: String
    let date: String
    
    static func chatListDummyData() -> [ChatListModel] {
        return [
            ChatListModel(nickName: "정이는포켓몬", messagePreview: "넵!", date: "10/06"),
            ChatListModel(nickName: "두두", messagePreview: "감사합니다~", date: "09/25"),
            ChatListModel(nickName: "정이", messagePreview: "좋아요~!", date: "08/11"),
            ChatListModel(nickName: "윤서", messagePreview: "여기요 !!", date: "06/22")
        ]
    }
}
