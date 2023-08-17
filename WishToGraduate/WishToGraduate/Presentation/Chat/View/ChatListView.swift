//
//  ChatListView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/08/17.
//

import UIKit

import SnapKit
import Then

final class ChatListView: UIScrollView {
    
    // MARK: - UI Components
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatListView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
