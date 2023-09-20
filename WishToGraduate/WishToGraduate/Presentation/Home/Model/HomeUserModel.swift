//
//  HomeUserModel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/21.
//

import UIKit

struct HomeUserModel {
    let userName: String
    let point: Int
}

extension HomeUserModel {
    
    static func homeUserModelDummyData() -> HomeUserModel {
        return HomeUserModel(userName: "블로우", point: 5)
    }
}
