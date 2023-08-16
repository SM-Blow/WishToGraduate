//
//  CustomTextFieldView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/08/16.
//

import UIKit

import SnapKit
import Then

class CustomTextFieldView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
    // MARK: - Initializer
    
    init(type: String) {
        super.init(frame: .zero)
        setUI(type)
        setLayout(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextFieldView {
    
    private func setUI(_ type: String) {
        
        backgroundColor = .clear
        
        titleLabel.do {
            $0.text = type
            $0.font = .fontGuide(.m1)
            $0.textColor = Color.placeholder_Grey
        }
        
        textField.do {
            $0.placeholder = "\(type)를 입력하세요."
            $0.font = .fontGuide(.m1)
            $0.textColor = Color.placeholder_Grey
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.makeShadow(radius: 5, offset: CGSize(width: 0, height: 0), opacity: 0.08)
            $0.backgroundColor = .white
            $0.setLeftPaddingPoints(14)
        }
    }
    
    private func setLayout(_ type: String) {
        
        addSubviews(titleLabel, textField)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
