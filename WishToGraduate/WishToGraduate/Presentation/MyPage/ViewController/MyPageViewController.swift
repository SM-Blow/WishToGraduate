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
    
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
