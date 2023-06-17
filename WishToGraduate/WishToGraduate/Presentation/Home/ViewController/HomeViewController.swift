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

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationStackView = UIStackView()
    private let notificationButton = UIButton()
    private let searchButton = UIButton()
    private let logoImage = UIImageView()
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let categoryModel = CategoryModel.categoryModelData()
    private let selectedCategoryModel = CategoryModel.selectedCategoryModelData()
    private let homeListView = HomeListView()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNavigationBar()
        setDelegate()
        setRegister()
    }
}

extension HomeViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        
        navigationStackView.do {
            $0.isLayoutMarginsRelativeArrangement = true
            $0.alignment = .trailing
            $0.distribution = .equalCentering
            $0.spacing = 2
        }
        
        notificationButton.do {
            $0.setImage(Image.notificationButton, for: .normal)
        }
        
        searchButton.do {
            $0.setImage(Image.searchButton, for: .normal)
        }
        
        logoImage.do {
            $0.image = Image.profileImage
        }
        
        categoryCollectionView.do {
            $0.isScrollEnabled = true
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        navigationStackView.addArrangedSubviews(notificationButton, searchButton)
        view.addSubviews(categoryCollectionView, homeListView)
        
        navigationStackView.snp.makeConstraints {
            $0.width.equalTo(72)
            $0.height.equalTo(35)
        }
        
        notificationButton.snp.makeConstraints {
            $0.width.height.equalTo(35)
        }
        
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(35)
        }
        
        logoImage.snp.makeConstraints {
            $0.width.height.equalTo(41)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(19)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(65)
        }
        
        homeListView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoImage)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationStackView)
    }
    
    private func setDelegate() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    private func setRegister() {
        categoryCollectionView.registerCell(CategoryCollectionViewCell.self)
    }
    
    // MARK: - @objc Methods
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            cell.imageDataBind(model: selectedCategoryModel[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            cell.imageDataBind(model: categoryModel[indexPath.row])
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: CategoryCollectionViewCell.self, indexPath: indexPath)
        if indexPath.row == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
            cell.setDataBind(model: selectedCategoryModel[indexPath.row])
        } else {
            cell.setDataBind(model: categoryModel[indexPath.row])
        }
        return cell
    }
}
