//
//  HomeNavigationView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/07/25.
//

import UIKit

import SnapKit
import Then

final class ShareNavigationView: UIView {
    
    // MARK: - UI Components
    
    private let backButton = UIButton()
    private let shareLabel = UILabel()
    private let notificationButton = UIButton()
    private let writeButton = UIButton()
    private let searchButton = UIButton()
    
    // MARK: - Properties
    
    var backButtonHandler: (() -> Void)?
    var searchButtonHandler: (() -> Void)?
    var writeButtonHandler: (() -> Void)?
    
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

extension ShareNavigationView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = Color.light_Green
        
        backButton.do {
            $0.setImage(Image.backButton, for: .normal)
        }
        
        shareLabel.do {
            $0.text = "공유하기"
            $0.font = .fontGuide(.h1)
            $0.textColor = Color.main_Green
        }
        
        notificationButton.do {
            $0.setImage(Image.notificationButton, for: .normal)
        }
        
        searchButton.do {
            $0.setImage(Image.searchButton, for: .normal)
        }
        
        writeButton.setImage(Image.selectedWriting, for: .normal)
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(backButton, notificationButton, writeButton, searchButton, shareLabel)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(9)
        }
        
        shareLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
        
        writeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(25)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-2)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        searchButton.addTarget(self, action: #selector(searchButtonDidTapped), for: .touchUpInside)
        writeButton.addTarget(self, action: #selector(writeButtonDidTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func searchButtonDidTapped() {
        searchButtonHandler?()
    }
    
    @objc
    private func writeButtonDidTapped() {
        writeButtonHandler?()
    }
    
    @objc
    private func backButtonDidTapped() {
        backButtonHandler?()
    }
}
