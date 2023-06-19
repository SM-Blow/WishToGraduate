//
//  TabBarItem.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/17.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case writing
    case myprofile
}

extension TabBarItemType {
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .writing:
            return "글쓰기"
        case .myprofile:
            return "마이"
        }
    }
    
    var unSelectedIcon: UIImage {
        switch self {
        case .home:
            return Image.home
        case .writing:
            return Image.writing
        case .myprofile:
            return Image.myProfile
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return Image.selectedHome
        case .writing:
            return Image.selectedWriting
        case .myprofile:
            return Image.selectedMyProfile
        }
    }
    
    public func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: title, image: unSelectedIcon, selectedImage: selectedIcon)
    }
}
