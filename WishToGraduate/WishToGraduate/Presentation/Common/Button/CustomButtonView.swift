//
//  CustomButtonView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/19.
//

import UIKit

import SnapKit
import Then

final class CustomButtonView: UIView {
    
    // MARK: - UI Components
    
    private let topLineView = UIView()
    private let button = UIButton()
    
    // MARK: - View Life Cycle
    
    init(title: String) {
        super.init(frame: .zero)
        setUI(title)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomButtonView {
    
    // MARK: - UI Components Property
    
    private func setUI(_ title: String) {
        
        topLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
        
        button.do {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .fontGuide(.title_bold)
            $0.backgroundColor = Color.main2_Green
            $0.makeCornerRound(radius: 10)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        backgroundColor = .clear
        
        topLineView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(topLineView.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(22)
            $0.height.equalTo(45)
        }
    }
}
