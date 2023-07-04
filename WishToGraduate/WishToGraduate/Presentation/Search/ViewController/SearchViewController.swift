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
    private let searchButton = UIButton()
    private let searchTextField = UITextField()
    
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
        
        searchButton.do {
            $0.setImage(Image.searchButton, for: .normal)
        }
        
        searchTextField.do {
            $0.placeholder = "키워드를 입력해주세요."
            $0.textColor = .black
            $0.layer.cornerRadius = 5
            $0.layer.borderColor = Color.main_Green.cgColor
            $0.layer.borderWidth = 1
            $0.setLeftPaddingPoints(12)
            $0.font = .fontGuide(.placeholder)
            $0.rightView = searchButton
            $0.rightViewMode = .always
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(underLineView, searchTextField)
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(35)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(18)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(18)
            $0.height.equalTo(43)
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
