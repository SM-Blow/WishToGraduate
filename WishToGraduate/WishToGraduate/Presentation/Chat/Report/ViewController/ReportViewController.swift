//
//  ReportViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/04.
//

import UIKit

import Moya
import SnapKit
import Then

final class ReportViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar(title: "사용자 신고하기")
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNavigationButton()
    }
}

extension ReportViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
    }
    
    // MARK: - Methods
    
    private func popToChatVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func setNavigationButton() {
        navigationBar.backButtonHandler = { [weak self] in
            self?.popToChatVC()
        }
    }
}
