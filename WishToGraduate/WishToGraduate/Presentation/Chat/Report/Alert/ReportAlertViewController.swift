//
//  ReportAlertView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/04.
//

import UIKit

import SnapKit
import Then

final class ReportAlertViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let containerView = UIView()
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let homeButton = UIButton()
    
    // MARK: - Properties
    
    var homeButtonHandler: (() -> Void)?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        setUI()
        setLayout()
        setAddTarget()
    }
}

extension ReportAlertViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.background_Grey
        
        containerView.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 10)
        }
        
        titleLabel.do {
            $0.text = "신고가 성공적으로 접수되었습니다."
            $0.font = .fontGuide(.m1)
            $0.textColor = .black
        }
        
        homeButton.do {
            $0.setTitle("홈으로 돌아가기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = Color.circle_LightGreen
            $0.titleLabel?.font = .fontGuide(.h2)
            $0.makeCornerRound(radius: 15)
            $0.makeBorder(width: 1, color: Color.placeholder_Grey)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(containerView)
        containerView.addSubviews(titleLabel, homeButton)
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(43)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 143 / 812)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.centerX.equalToSuperview()
        }
        
        homeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(35)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(112)
            $0.height.equalTo(30)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        homeButton.addTarget(self, action: #selector(homeButtonDidTapped), for: .touchUpInside)
    }
    
    private func backToHome() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            let vc = HomeViewController()
            let rootVC = UINavigationController(rootViewController: vc)
            rootVC.navigationController?.isNavigationBarHidden = true
            window.rootViewController = rootVC
            window.makeKeyAndVisible()
        }
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func homeButtonDidTapped() {
        backToHome()
    }
}
