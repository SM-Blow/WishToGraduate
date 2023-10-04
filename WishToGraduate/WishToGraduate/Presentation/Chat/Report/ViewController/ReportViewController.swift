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
    
    private let navigationView = CustomNavigationBar(title: "사용자 신고하기")
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension ReportViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        navigationView.do {
            $0.isBackButtonIncluded = true
        }
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationView)
        
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
