//
//  ChattingView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/02.
//

import UIKit

import SnapKit
import Then

final class ChattingView: UIView {
    
    // MARK: - UI Components
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChattingView {
    
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
