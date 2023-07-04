//
//  SearchViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/26.
//

import UIKit

import Then
import SnapKit

class SearchViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let closeImageView = UIImageView()
    private let underLineView = UIView()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNavigationBar()
    }
}

extension SearchViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        closeImageView.do {
            $0.image = Image.closeButton
        }
        
        underLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(underLineView)
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = Color.light_Green
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Color.main_Green,
            .font: UIFont.fontGuide(.h1)
        ]
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeImageView)
        navigationItem.title = "검색하기"
    }
}
