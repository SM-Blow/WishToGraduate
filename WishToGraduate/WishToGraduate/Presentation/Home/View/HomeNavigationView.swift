//
//  HomeNavigationView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/07/25.
//

import UIKit

import SnapKit
import Then

final class HomeNavigationView: UIView {
    
    // MARK: - UI Components
    
    private let logoImage = UIImageView()
    private let notificationButton = UIButton()
    private let searchButton = UIButton()
    
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

extension HomeNavigationView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = Color.light_Green
        
        logoImage.do {
            $0.image = Image.profileImage
        }
        
        notificationButton.do {
            $0.setImage(Image.notificationButton, for: .normal)
        }
        
        searchButton.do {
            $0.setImage(Image.searchButton, for: .normal)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(logoImage, notificationButton, searchButton)
        
        logoImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(23)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
        
        notificationButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(searchButton.snp.leading).offset(2)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
