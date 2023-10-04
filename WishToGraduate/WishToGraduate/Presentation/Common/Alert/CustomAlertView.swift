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

final class CustomAlertViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let containerView = UIView()
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let explainLabel = UILabel()
    private let allowButton = UIButton()
    private let cancelButton = UIButton()
    
    // MARK: - Properties
    
    var allowButtonHandler: (() -> Void)?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        setLayout()
        setAddTarget()
    }
}

extension CustomAlertViewController {
    
    // MARK: - UI Components Property
    
    func setTitle(_ title: String) {
        setUI(title)
    }
    
    private func setUI(_ title: String) {
        
        view.backgroundColor = Color.background_Grey
        
        containerView.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 10)
        }
        
        titleLabel.do {
            $0.text = title
            $0.font = .fontGuide(.m1)
            $0.textColor = .black
        }
        
        explainLabel.do {
            $0.font = .fontGuide(.h2)
        }
        
        allowButton.do {
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
        
        view.addSubviews(containerView)
        containerView.addSubviews(titleLabel, explainLabel, cancelButton, allowButton)
        
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
    
    func setAlert(_ alertType: CustomAlertType) {
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
        allowButton.addTarget(self, action: #selector(allowButtonDidTapped), for: .touchUpInside)
    }
    
    private func closeAlertView() {
        self.dismiss(animated: true)
    }
    
    private func allowAlert() {
        allowButtonHandler?()
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func cancelButtonDidTapped() {
        closeAlertView()
    }
    
    @objc
    private func allowButtonDidTapped() {
        allowAlert()
    }
}
