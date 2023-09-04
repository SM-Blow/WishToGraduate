//
//  ChatModel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/03.
//

import Foundation

enum ChatType: CaseIterable {
    case receive
    case send
}

struct ChatModel {
    let message: String
    let chatType: ChatType
}

extension ChatModel {
    
    static func chatModelDummyData() -> [ChatModel] {
        return [
            ChatModel(message: "안녕하세요! 저 충전기 지금 빌려드릴 수 있어요! \n지금 도서관 2층입니다!", chatType: .send),
            ChatModel(message: "앗 안녕하세요! \n50분에 2층 도서관 엘베 앞에서 보는 거 어떠세요?", chatType: .receive),
            ChatModel(message: "좋아요!", chatType: .send),
            ChatModel(message: "감사합니다! \n좋은 하루 보내세요~", chatType: .send),
            ChatModel(message: "넵!", chatType: .receive),
            ChatModel(message: "내가 해냈다 이거 키보드처리.", chatType: .send),
            ChatModel(message: "다은아 진호야 지호야 잘 먹고 잇니?", chatType: .receive),
            ChatModel(message: "잘 먹고 잇어", chatType: .send),
            ChatModel(message: "이제 라벨 미묘한 여백만 처리하면 되겠네?", chatType: .send),
            ChatModel(message: "안녕하세요! 저 충전기 지금 빌려드릴 수 있어요! \n지금 도서관 2층입니다!", chatType: .send),
            ChatModel(message: "앗 안녕하세요! \n50분에 2층 도서관 엘베 앞에서 보는 거 어떠세요?", chatType: .receive),
            ChatModel(message: "좋아요!", chatType: .send),
            ChatModel(message: "감사합니다! \n좋은 하루 보내세요~", chatType: .send),
            ChatModel(message: "넵!", chatType: .receive),
            ChatModel(message: "내가 해냈다 이거 키보드처리.", chatType: .send),
            ChatModel(message: "다은아 진호야 지호야 잘 먹고 잇니?", chatType: .receive),
            ChatModel(message: "잘 먹고 잇어", chatType: .send),
            ChatModel(message: "이제 라벨 미묘한 여백만 처리하면 되겠네?", chatType: .send)
        ]
    }
}
