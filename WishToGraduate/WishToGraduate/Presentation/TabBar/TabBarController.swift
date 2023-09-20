//
//  TabBarController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/17.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private var tabs: [UIViewController] = []
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarUI()
        setTabBarItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 75 + getSafeAreaBottomHeight()
    }
}

extension TabBarController {
    
    private func setTabBarItems() {

        tabs = [
            ShareViewController(),
            ChatListViewController(),
            MyPageViewController()
        ]
        
        TabBarItemType.allCases.forEach {
            let tabBarItem = $0.setTabBarItem()
            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -14)
            tabs[$0.rawValue].tabBarItem = tabBarItem
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        setViewControllers(tabs, animated: false)
    }
    
    private func setTabBarUI() {
        UITabBar.clearShadow()
        tabBar.tintColor = Color.main_Green
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = Color.line_Grey.cgColor
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 1
        let fontAttributes = [
            NSAttributedString.Key.font: UIFont.fontGuide(.m1)
        ]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    private func getSafeAreaBottomHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let safeAreaInsets = windowScene.windows.first?.safeAreaInsets
            let bottomSafeAreaHeight = safeAreaInsets?.bottom ?? 0
            return bottomSafeAreaHeight
        }
        return 0
    }
}
