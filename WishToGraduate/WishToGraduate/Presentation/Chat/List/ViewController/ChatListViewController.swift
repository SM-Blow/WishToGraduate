//
//  ChatListViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/08/17.
//

import UIKit

import Moya
import SnapKit
import Then

final class ChatListViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = CustomNavigationView(title: "채팅")
    private let chatListView = ChatListView()
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension ChatListViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        
        navigationView.do {
            $0.isCloseButtonIncluded = true
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationView, chatListView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        chatListView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
    }
}
