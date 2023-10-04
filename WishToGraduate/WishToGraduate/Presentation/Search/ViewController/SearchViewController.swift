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
    
    private let navigationView = CustomNavigationBar(title: "검색하기")
    private let backImageView = UIImageView()
    private let searchView = UIView()
    private let searchButton = UIButton()
    private let searchButtonView = UIView()
    private let searchTextField = UITextField()
    private let searchListView = ShareListView()
    
    // MARK: - Properties
    
    weak var searchDelegate: SearchProtocol?
    private var searchList: [Post] = []
    
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
        
        navigationView.do {
            $0.isBackButtonIncluded = true
        }
        
        backImageView.do {
            $0.image = Image.backButton
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
        view.addSubviews(navigationView, searchView, searchListView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(35)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
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
    
    private func popToShareVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func emptyListActivation() {
        searchDelegate?.searchType(type: .empty)
    }
    
    private func searchListActivation() {
        searchDelegate?.searchType(type: .search)
    }
    
    private func pushToDetailVC() {
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func searchButtonTapped() {
        requestGetSearchList()
    }
    
    @objc
    private func setButton() {
        navigationView.backButtonHandler = { [weak self] in
            self?.popToShareVC()
        }
    }
    
    @objc
    private func setHandler() {
        searchListView.pushToDetailHandler = { [weak self] in
            self?.pushToDetailVC()
        }
    }
}

extension SearchViewController: SearchProtocol {
    
    func searchType(type: SearchSection) {
        searchListView.setSearchListModel(type: type, model: searchList)
    }
}

extension SearchViewController {
    private func requestGetSearchList() {
        PostAPI.shared.getSearchPost(keyword: searchTextField.text ?? "") { [weak self] response in
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.searchList = data.postList
            self?.searchListActivation()
        }
    }
}
