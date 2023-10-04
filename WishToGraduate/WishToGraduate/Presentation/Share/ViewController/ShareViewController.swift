//
//  HomeViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/16.
//

import UIKit

import Moya
import SnapKit
import Then

protocol CategoryProtocol: AnyObject {
    func categoryType(category: CategorySection)
}

final class ShareViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = ShareNavigationView()
    let categoryModel = CategoryModel.categoryModelData()
    let selectedCategoryModel = CategoryModel.selectedCategoryModelData()
    private lazy var categoryCollectionView: CategoryCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = CategoryCollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let underLineView = UIView()
    private let homeListView = ShareListView()
    
    // MARK: - Properties
    
    weak var categoryDelegate: CategoryProtocol?
    private var shareList: [Post] = []
    private var shareCategory: CategorySection = .all
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setButton()
        setCellHandler()
        requestGetPostList()
    }
}

extension ShareViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        
        underLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
        
        categoryCollectionView.do {
            $0.isScrollEnabled = true
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
    
        view.addSubviews(navigationView, categoryCollectionView, underLineView, homeListView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(65)
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalTo(homeListView.snp.top)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        
        homeListView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        categoryCollectionView.delegate = self
        categoryDelegate = self
    }
    
    private func presentToSearchVC() {
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    private func pushToDetailVC() {
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    private func backToHomeVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentToWriteVC() {
        let writeVC = WriteViewController()
        writeVC.modalPresentationStyle = .fullScreen
        self.present(writeVC, animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func setButton() {
        navigationView.searchButtonHandler  = { [weak self] in
            self?.presentToSearchVC()
        }
        navigationView.writeButtonHandler = { [weak self] in
            self?.presentToWriteVC()
        }
        navigationView.backButtonHandler = { [weak self] in
            self?.backToHomeVC()
        }
    }
    
    @objc
    private func setCellHandler() {
        homeListView.pushToDetailHandler = { [weak self] in
            self?.pushToDetailVC()
        }
    }
}

extension ShareViewController {
    private func requestGetPostList() {
        PostAPI.shared.getAllPost { [weak self] response in
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.homeListView.setListModel(category: .all, model: data.postList)
        }
    }
    
    private func requestCategoryPostList() {
        PostAPI.shared.getPostByCategory(category: categoryToString(shareCategory)) { [weak self] response in
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.homeListView.setListModel(category: self?.shareCategory ?? .all, model: data.postList)
        }
    }
    
    private func categoryToString(_ category: CategorySection) -> String {
        switch category {
        case .all:
            return "전체"
        case .book:
            return "도서"
        case .charger:
            return "전자기기"
        case .delivery:
            return "배달"
        case .insecticide:
            return "벌레"
        case .other:
            return "기타"
        }
    }
}

extension ShareViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 59, height: 59)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            cell.imageDataBind(model: categoryModel[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            cell.imageDataBind(model: selectedCategoryModel[indexPath.row])
        }
        
        let category = CategorySection.allCases[indexPath.row]
        shareCategory = category
        switch category {
        case .all:
            categoryDelegate?.categoryType(category: .all)
        case .book:
            categoryDelegate?.categoryType(category: .book)
        case .charger:
            categoryDelegate?.categoryType(category: .charger)
        case .delivery:
            categoryDelegate?.categoryType(category: .delivery)
        case .insecticide:
            categoryDelegate?.categoryType(category: .insecticide)
        case .other:
            categoryDelegate?.categoryType(category: .other)
        }
        requestCategoryPostList()
    }
}

extension ShareViewController: CategoryProtocol {
    
    func categoryType(category: CategorySection) {
        homeListView.setListModel(category: category, model: shareList)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
