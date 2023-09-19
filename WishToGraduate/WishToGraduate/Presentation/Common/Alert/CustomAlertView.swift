//
//  CustomAlertView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/19.
//

import UIKit

import SnapKit
import Then

enum CustomAlertType {
    case useCoupon
    case applicationEvent
}

final class CustomAlertView: UIView {
    
    // MARK: - UI Components
    
    private let containerView = UIView()
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let explainLabel = UILabel()
    private let allowButton = UIButton()
    private let cancelButton = UIButton()
    
    // MARK: - View Life Cycle
    
    init(alertType: CustomAlertType) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        setAddTarget()
        setAlert(alertType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomAlertView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = Color.background_Grey
        
        containerView.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 10)
        }
        
        titleLabel.do {
            $0.text = "2023 2학기 소프트웨어학부 개강총회"
            $0.font = .fontGuide(.m1)
            $0.textColor = .black
        }
        
        explainLabel.do {
            $0.font = .fontGuide(.h2)
        }
        
        allowButton.do {
            $0.setTitle("신청", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = Color.circle_LightGreen
            $0.titleLabel?.font = .fontGuide(.h2)
            $0.makeCornerRound(radius: 15)
            $0.makeBorder(width: 1, color: Color.placeholder_Grey)
        }
        
        cancelButton.do {
            $0.setTitle("취소", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = Color.line_Grey
            $0.titleLabel?.font = .fontGuide(.h2)
            $0.makeCornerRound(radius: 15)
            $0.makeBorder(width: 1, color: Color.placeholder_Grey)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(containerView)
        containerView.addSubviews(titleLabel, explainLabel, cancelButton, allowButton)
        
        self.frame = CGRect(
            x: 0,
            y: 0,
            width: SizeLiterals.Screen.screenWidth * 292 / 375,
            height: SizeLiterals.Screen.screenHeight * 158 / 812
        )
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(43)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 158 / 812)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.centerX.equalToSuperview()
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(53)
            $0.width.equalTo(68)
            $0.height.equalTo(30)
        }
        
        allowButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton)
            $0.trailing.equalToSuperview().inset(53)
            $0.width.equalTo(68)
            $0.height.equalTo(30)
        }
    }
    
    // MARK: - Methods
    
    private func setAlert(_ alertType: CustomAlertType) {
        switch alertType {
        case .useCoupon:
            explainLabel.text = "쿠폰을 사용 처리합니다."
            allowButton.setTitle("사용", for: .normal)
        case .applicationEvent:
            explainLabel.text = "행사에 신청합니다."
            allowButton.setTitle("신청", for: .normal)
        }
    }
    
    private func setAddTarget() {
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
    }
    
    private func closeAlertView() {
        removeFromSuperview()
    }
    
    // MARK: - @objc Methods
    
    @objc 
    private func cancelButtonDidTapped() {
        closeAlertView()
    }
}
