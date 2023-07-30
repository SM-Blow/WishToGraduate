//
//  MyPageViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/17.
//

import UIKit

import Moya
import SnapKit
import Then

final class MyPageViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = MyPageNavigationView()
    private let myProfileView = MyProfileView()
    private let underLineView = UIView()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension MyPageViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
    
        underLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationView, myProfileView, underLineView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        myProfileView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(235)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(myProfileView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
