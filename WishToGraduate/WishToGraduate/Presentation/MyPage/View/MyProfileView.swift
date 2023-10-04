//
//  MyProfileView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/07/30.
//

import UIKit

import SnapKit
import Then

final class MyProfileView: UIView {
    
    // MARK: - UI Components
    
    private let profileImage = UIImageView()
    private let nicknameLabel = UILabel()
    private let myPointLabel = UILabel()
    
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

extension MyProfileView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
        
        profileImage.do {
            $0.image = Image.profileImage
        }
        
        nicknameLabel.do {
            $0.font = .fontGuide(.m1)
            $0.textColor = .black
        }
        
        myPointLabel.do {
            $0.font = .fontGuide(.h2)
            $0.textColor = .black
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(profileImage, nicknameLabel, myPointLabel)
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(65)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        myPointLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(27)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func setDataBind(nickName: String, seed: Int) {
        print("aseflija;eifj;ailjef;laj")
        myPointLabel.text = "나의 씨앗     |    \(seed)개"
        nicknameLabel.text = nickName
    }
}
