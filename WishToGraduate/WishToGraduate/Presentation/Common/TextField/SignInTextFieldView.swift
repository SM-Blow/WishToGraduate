//
//  CustomTextFieldView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/08/16.
//

import UIKit

import SnapKit
import Then

class SignInTextFieldView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    let textField = UITextField()
    
    // MARK: - Properties
    
    var isTitleIncluded: Bool {
        get { !titleLabel.isHidden }
        set { titleLabel.isHidden = !newValue }
    }
    
    // MARK: - Initializer
    
    init(type: String) {
        super.init(frame: .zero)
        setUI(type)
        setLayout(type)
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInTextFieldView {
    
    // MARK: - UI Components Property
    
    private func setUI(_ type: String) {
        
        backgroundColor = .clear
        
        titleLabel.do {
            $0.text = type
            $0.font = .fontGuide(.m1)
            $0.textColor = Color.placeholder_Grey
            $0.isHidden = true
        }
        
        textField.do {
            $0.placeholder = "\(type)를 입력하세요."
            $0.font = .fontGuide(.m1)
            $0.textColor = Color.placeholder_Grey
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.makeShadow(radius: 5, offset: CGSize(width: 0, height: 0), opacity: 0.08)
            $0.backgroundColor = .white
            $0.setLeftPaddingPoints(14)
            
            if type == "비밀번호" {
                $0.isSecureTextEntry = true
            }
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout(_ type: String) {
        
        addSubviews(titleLabel, textField)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        textField.delegate = self
    }
    
    func nickNamePlaceholder() {
        textField.placeholder = "닉네임을 입력하세요."
    }
    
    func getTextFieldText() -> String {
        return textField.text ?? ""
    }
}

extension SignInTextFieldView: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.textColor = .black
    }
}
