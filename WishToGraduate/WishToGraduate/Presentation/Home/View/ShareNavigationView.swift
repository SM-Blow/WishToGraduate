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
    
    private let logoImage = UIImageView()
    private let notificationButton = UIButton()
    private let writeButton = UIButton()
    private let searchButton = UIButton()
    
    // MARK: - Properties
    
    var searchButtonHandler: (() -> Void)?
    var writeButtonHandler: (() -> Void)?
    
    // MARK: - Initializer
    
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
        
        logoImage.do {
            $0.image = Image.profileImage
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
        
        addSubviews(logoImage, notificationButton, writeButton, searchButton)
        
        logoImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(23)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
        
        writeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-2)
        }
//
//        notificationButton.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.trailing.equalTo(writeButton.snp.leading).offset(5)
//        }
        
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        searchButton.addTarget(self, action: #selector(searchButtonDidTapped), for: .touchUpInside)
        writeButton.addTarget(self, action: #selector(writeButtonDidTapped), for: .touchUpInside)
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
}
