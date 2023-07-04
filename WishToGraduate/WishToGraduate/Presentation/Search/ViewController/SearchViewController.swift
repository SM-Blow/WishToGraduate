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
    private let searchView = UIView()
    private let searchButton = UIButton()
    private let searchButtonView = UIView()
    private let searchTextField = UITextField()
    private let searchListView = HomeListView()
    
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
        
        view.backgroundColor = Color.light_Green
        
        closeImageView.do {
            $0.image = Image.closeButton
        }
        
        underLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
        
        searchView.do {
            $0.backgroundColor = .white
        }
        
        searchButton.do {
            $0.setImage(Image.searchButton, for: .normal)
        }
        
        searchButtonView.do {
            $0.backgroundColor = .clear
        }
        
        searchTextField.do {
            $0.placeholder = "키워드를 입력해주세요."
            $0.textColor = .black
            $0.layer.cornerRadius = 5
            $0.layer.borderColor = Color.main_Green.cgColor
            $0.layer.borderWidth = 1
            $0.setLeftPaddingPoints(12)
            $0.font = .fontGuide(.placeholder)
            $0.rightView = searchButtonView
            $0.rightViewMode = .always
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        searchButtonView.addSubviews(searchButton)
        searchView.addSubviews(searchTextField)
        view.addSubviews(underLineView, searchView, searchListView)
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(35)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(61)
        }
        
        searchButtonView.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(35)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(43)
        }
        
        searchListView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Color.main_Green,
            .font: UIFont.fontGuide(.h1)
        ]
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeImageView)
        navigationItem.title = "검색하기"
    }
}
