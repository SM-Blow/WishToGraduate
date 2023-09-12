//
//  WriteNavigationView.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/10.
//

import UIKit

import Then
import SnapKit

final class WriteNavigationView: UIView {

    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let underLineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WriteNavigationView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = Color.light_Green
        
        titleLabel.do {
            $0.text = "글 작성"
            $0.font = .fontGuide(.h1)
            $0.textColor = Color.main_Green
        }
        
        underLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(titleLabel, underLineView)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
