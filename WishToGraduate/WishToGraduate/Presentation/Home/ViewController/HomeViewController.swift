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

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = HomeNavigationView()
    let categoryModel = CategoryModel.categoryModelData()
    let selectedCategoryModel = CategoryModel.selectedCategoryModelData()
    private lazy var categoryCollectionView: CategoryCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = CategoryCollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let underLineView = UIView()
    private let homeListView = HomeListView()
    
    // MARK: - Properties
    
    weak var categoryDelegate: CategoryProtocol?
    
    // MARK: - Initializer
    
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
    }
}

extension HomeViewController {
    
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
    
    func presentToSearchVC() {
        let searchVC = SearchViewController()
        searchVC.modalPresentationStyle = .fullScreen
        self.present(searchVC, animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func setButton() {
        navigationView.searchButtonHandler  = { [weak self] in
            self?.presentToSearchVC()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
        switch category {
        case .all:
            categoryDelegate?.categoryType(category: .all)
        case .pill:
            categoryDelegate?.categoryType(category: .pill)
        case .sanitaryPad:
            categoryDelegate?.categoryType(category: .sanitaryPad)
        case .charger:
            categoryDelegate?.categoryType(category: .charger)
        case .book:
            categoryDelegate?.categoryType(category: .book)
        case .other:
            categoryDelegate?.categoryType(category: .other)
        }
    }
}

extension HomeViewController: CategoryProtocol {
    
    func categoryType(category: CategorySection) {
        homeListView.setListModel(category: category)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
