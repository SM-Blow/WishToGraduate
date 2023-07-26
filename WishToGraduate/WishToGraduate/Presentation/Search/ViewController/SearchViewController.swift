//
//  SearchViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/26.
//

import UIKit

import Then
import SnapKit

protocol SearchProtocol: AnyObject {
    func searchType(type: SearchSection)
}

class SearchViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = SearchNavigationView()
    private let backImageView = UIImageView()
    private let underLineView = UIView()
    private let searchView = UIView()
    private let searchButton = UIButton()
    private let searchButtonView = UIView()
    private let searchTextField = UITextField()
    private let searchListView = HomeListView()
    
    // MARK: - Properties
    
    weak var searchDelegate: SearchProtocol?
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
        emptyListActivation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setAddTarget()
        setButton()
    }
}

extension SearchViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        
        backImageView.do {
            $0.image = Image.backButton
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
        view.addSubviews(navigationView, underLineView, searchView, searchListView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
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
    
    private func setDelegate() {
        searchDelegate = self
    }
    
    private func setAddTarget() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func popToHomeVC() {
        navigationController?.popViewController(animated: true)
    }
    
    private func emptyListActivation() {
        searchDelegate?.searchType(type: .empty)
    }
    
    private func searchListActivation() {
        searchDelegate?.searchType(type: .search)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func searchButtonTapped() {
        searchListActivation()
    }
    
    @objc
    private func setButton() {
        navigationView.closeButtonHandler  = { [weak self] in
            self?.popToHomeVC()
        }
    }
}

extension SearchViewController: SearchProtocol {
    
    func searchType(type: SearchSection) {
        searchListView.setSearchListModel(type: type)
    }
}
