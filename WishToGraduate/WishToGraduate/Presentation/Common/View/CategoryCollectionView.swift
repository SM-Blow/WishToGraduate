//
//  CategoryCollectionView.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/10.
//

import UIKit

final class CategoryCollectionView: UICollectionView {

    // MARK: - Properties
    
    weak var categoryDelegate: CategoryProtocol?
    
    let categoryModel = CategoryModel.categoryModelData()
    let selectedCategoryModel = CategoryModel.selectedCategoryModelData()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setUI()
        setRegister()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRegister() {
        self.registerCell(CategoryCollectionViewCell.self)
    }
    
    private func setUI() {
        isScrollEnabled = true
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
    }
    
    private func setDelegate() {
        dataSource = self
    }
}

extension CategoryCollectionView: UICollectionViewDataSource {
    
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
