//
//  SearchNavigationView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/07/25.
//

import UIKit

import SnapKit
import Then

final class CustomNavigationView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let underLineView = UIView()
    
    // MARK: - Properties
    
    var closeButtonHandler: (() -> Void)?
    
    // MARK: - View Life Cycle
    
    init(title: String) {
        super.init(frame: .zero)
        setUI(title)
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomNavigationView {
    
    // MARK: - UI Components Property
    
    private func setUI(_ title: String) {
        
        backgroundColor = Color.light_Green
        
        titleLabel.do {
            $0.text = title
            $0.font = .fontGuide(.h1)
            $0.textColor = Color.main_Green
        }
        
        closeButton.do {
            $0.setImage(Image.closeButton, for: .normal)
        }
        
        underLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(titleLabel, closeButton, underLineView)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        closeButton.addTarget(self, action: #selector(closeButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func closeButtonDidTapped() {
        closeButtonHandler?()
    }
}
