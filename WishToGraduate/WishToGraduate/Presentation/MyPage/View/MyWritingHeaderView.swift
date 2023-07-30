//
//  MyWritingHeaderView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/07/30.
//

import UIKit

import SnapKit
import Then

final class MyWritingHeaderView: UICollectionReusableView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    
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

extension MyWritingHeaderView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .clear
        
        titleLabel.do {
            $0.text = "내가 작성한 글"
            $0.font = .fontGuide(.h3)
            $0.textColor = .black
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(28)
        }
    }
}
