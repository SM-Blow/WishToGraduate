//
//  ChatListCollectionViewCell.swift
//  WishToGraduate
//
//  Created by KJ on 2023/08/17.
//

import UIKit

import SnapKit
import Then

final class ChatListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let profileImageView = UIImageView()
    private let nickNameLabel = UILabel()
    private let messagePreviewLabel = UILabel()
    private let dateLabel = UILabel()
    
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

extension ChatListCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = Color.btn_darkGrey.cgColor
        makeShadow(radius: 8, offset: CGSize(width: 0, height: 0), opacity: 0.12)
        
        profileImageView.do {
            $0.image = Image.profileImage
        }
        
        nickNameLabel.do {
            $0.text = "두두"
            $0.font = .fontGuide(.h2_bold)
            $0.textColor = Color.main_Green
        }
        
        messagePreviewLabel.do {
            $0.text  = "감사합니다! ㅎㅎ"
            $0.font = .fontGuide(.h2)
            $0.textColor = .black
        }
        
        dateLabel.do {
            $0.text = "05/23"
            $0.font = .fontGuide(.h2)
            $0.textColor = .black
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(profileImageView, nickNameLabel, messagePreviewLabel, dateLabel)
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(11)
            $0.size.equalTo(41)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(6)
        }
        
        messagePreviewLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(1)
            $0.leading.equalTo(nickNameLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(13)
        }
    }
}
