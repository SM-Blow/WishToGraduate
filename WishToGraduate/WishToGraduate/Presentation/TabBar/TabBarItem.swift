//
//  TabBarItem.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/17.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case chat
}

extension TabBarItemType {
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .chat:
            return "채팅"
        }
    }
    
    var unSelectedIcon: UIImage {
        switch self {
        case .home:
            return Image.home
        case .chat:
            return Image.chat
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return Image.selectedHome
        case .chat:
            return Image.selectedChat
        }
    }
    
    public func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: title, image: unSelectedIcon, selectedImage: selectedIcon)
    }
}
