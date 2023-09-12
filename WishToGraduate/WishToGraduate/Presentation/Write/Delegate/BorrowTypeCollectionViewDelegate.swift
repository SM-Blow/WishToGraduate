//
//  BorrowTypeCollectionViewDelegate.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/11.
//

import UIKit

final class BorrowTypeCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let borrowTypeModel = BorrowTypeModel.BorrowTypeDummyData()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return borrowTypeModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: BorrowTypeCollectionViewCell.self, indexPath: indexPath)
        cell.setDataBind(borrowTypeModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: 60, height: 30)
        default:
            return CGSize(width: 81, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BorrowTypeCollectionViewCell else { return }
        cell.setBackgroundColor()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BorrowTypeCollectionViewCell else { return }
        cell.setBackgroundColor()
    }
}
