//
//  CustomHomeButton.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/21.
//

import UIKit

enum HomeButtonType {
    case share
    case coupon
    case event
    case myPage
}

final class CustomHomeButton: UIView {
    
    // MARK: - UI Components
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let explainLabel = UILabel()
    
    // MARK: - Initializer

    init(_ type: HomeButtonType) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomHomeButton {
    
    // MARK: - UI Components Property
    
    private func setUI() {

        backgroundColor = .white
        makeCornerRound(radius: 20)
        makeShadow(radius: 8, offset: CGSize(width: 0, height: 0), opacity: 0.12)
        
        iconImageView.do {
            $0.image = Image.profileImage
        }
        
        titleLabel.do {
            $0.text = "공유하기"
            $0.font = .fontGuide(.title_bold)
            $0.textColor = .black
        }
        
        explainLabel.do {
            $0.text = "전자기기, 전공서적 등을\n공유해요"
            $0.font = .fontGuide(.date1)
            $0.textColor = .black
            $0.numberOfLines = 0
        }
    }
    
    private func setLayout() {
        
        addSubviews(iconImageView, titleLabel, explainLabel)
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(46)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(18)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.leading.equalTo(titleLabel)
        }
    }
}
