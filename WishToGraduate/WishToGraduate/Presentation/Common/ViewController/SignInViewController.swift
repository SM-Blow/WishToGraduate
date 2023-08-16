//
//  SignInViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/08/17.
//

import UIKit

import Moya
import SnapKit
import Then

final class SignInViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let idTextField = CustomTextFieldView(type: "아이디")
    private let passwordTextField = CustomTextFieldView(type: "비밀번호")
    private let signInButton = CustomCheckButton(title: "로그인")
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension SignInViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        
        logoImageView.do {
            $0.image = Image.profileImage
        }
        
        titleLabel.do {
            $0.text = "BLOW"
            $0.textColor = Color.main_Green
            $0.font = .fontGuide(.h1)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(logoImageView, titleLabel,
                         idTextField, passwordTextField, signInButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(55)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(80)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(-14)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(80)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(31)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
