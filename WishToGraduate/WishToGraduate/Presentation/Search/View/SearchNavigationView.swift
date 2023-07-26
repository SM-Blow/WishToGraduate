//
//  SearchNavigationView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/07/25.
//

import UIKit

import SnapKit
import Then

final class SearchNavigationView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    
    // MARK: - Properties
    
    var closeButtonHandler: (() -> Void)?
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchNavigationView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = Color.light_Green
        
        titleLabel.do {
            $0.text = "검색하기"
            $0.font = .fontGuide(.h1)
            $0.textColor = Color.main_Green
        }
        
        closeButton.do {
            $0.setImage(Image.closeButton, for: .normal)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(titleLabel, closeButton)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
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
