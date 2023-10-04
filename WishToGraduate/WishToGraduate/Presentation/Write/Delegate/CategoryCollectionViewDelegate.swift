//
//  CategoryCollectionViewDelegate.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/11.
//

import UIKit

final class CategoryCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
    let categoryModel = CategoryModel.categoryModelData()
    let selectedCategoryModel = CategoryModel.selectedCategoryModelData()
    weak var writeViewController: WriteViewController?
    
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
            writeViewController?.category = selectedCategoryModel[indexPath.row].title
        }
    }
}
