//
//  MyPageResponse.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/25.
//

struct MyPageResponse: Codable {
    let user: Int
    let nickName: String
    let seed: Int?
    let posts: [String]?
    let scraps: [String]?
    
    func convertToMypage() -> MypageModel {
        return MypageModel(userId: self.user, nickName: self.nickName, seed: self.seed ?? 0, post: self.posts ?? [], scrap: self.scraps ?? [])
    }
}
