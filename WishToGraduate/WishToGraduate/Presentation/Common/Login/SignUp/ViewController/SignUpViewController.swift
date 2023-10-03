//
//  SignUpViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/08/16.
//

import UIKit

import Moya
import SnapKit
import Then

var fcmToken: String?

final class SignUpViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let idTextField = SignInTextFieldView(type: "아이디")
    private let passwordTextField = SignInTextFieldView(type: "비밀번호")
    private let nickNameTextField = SignInTextFieldView(type: "닉네임")
    private let signUpButton = CustomCheckButton(title: "회원가입")

    // MARK: - Properties

    private var userModel: SignUpModel = SignUpModel(email: "", password: "", userName: "", deviceToken: "")
    private let userProvider = MoyaProvider<LoginService>(plugins:[NetworkLoggerPlugin()])
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        print("-----------------------------")
        print(fcmToken)
    }
}

extension SignUpViewController {
    
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
        
        idTextField.do {
            $0.isTitleIncluded = true
        }
        
        passwordTextField.do {
            $0.isTitleIncluded = true
        }
        
        nickNameTextField.do {
            $0.isTitleIncluded = true
            $0.nickNamePlaceholder()
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(logoImageView, titleLabel,
                         idTextField, passwordTextField, nickNameTextField, signUpButton)
        
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(23)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(80)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(idTextField)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(idTextField)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(31)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(50)
        }
    }
    
    private func setAddTarget() {
        signUpButton.addTarget(self, action: #selector(signupButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    func signupButtonDidTap() {
        postUserInfo()
//        let text = idTextField.textField.text ?? ""
//        if text.isValidSookmyungEmail() {
//            postUserInfo()
//        } else {
//            UIAlertController.showAlert(title: "잘못된 이메일입니다.", message: "숙명 이메일을 입력해주세요.")
//        }
    }
}

extension SignUpViewController {
    
    private func postUserInfo() {
        userModel.email = self.idTextField.textField.text ?? ""
        userModel.password = self.passwordTextField.textField.text ?? ""
        userModel.userName = self.nickNameTextField.textField.text ?? ""
        userModel.deviceToken = fcmToken ?? ""
        print("☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️")
        print(userModel.deviceToken)
        userProvider.request(.signUp(param: userModel.makeSignUpRequest())) { response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<SignUpResponse>.self).data else { return }
                        APIConstants.deviceToken = self.userModel.deviceToken
                        APIConstants.jwtToken = data.accessToken
                        
                        // 화면전환
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let sceneDelegate = windowScene.delegate as? SceneDelegate,
                           let window = sceneDelegate.window {
                            let vc = HomeViewController()
                            let rootVC = UINavigationController(rootViewController: vc)
                            rootVC.navigationController?.isNavigationBarHidden = true
                            window.rootViewController = rootVC
                            window.makeKeyAndVisible()
                        }
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                }
                else if status == 400 {
                    print("🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢")
                    print("400 error")
                    do {
                        let generalResponse = try result.map(GeneralResponse<SignUpRequest>.self)
                        guard let message = generalResponse.message else { return }
                        print(message)
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SignUpViewController: FCMTokenDelegate {
    
    // FCM 토큰을 받았을 때 호출되는 메서드
    func didReceiveFCMToken(_ token: String) {
        // FCM 토큰을 이용하여 원하는 작업을 수행합니다.
        print("전달되냐?", token)
        fcmToken = token
        print("🐸🐸🐸🐸🐸🐸🐸🐸🐸🐸🐸🐸🐸🐸🐸🐸🐸")
        print(fcmToken)
    }
}
