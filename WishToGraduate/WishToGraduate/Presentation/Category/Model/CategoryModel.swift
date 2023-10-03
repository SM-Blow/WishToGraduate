//
//  CategoryModel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/16.
//

import UIKit

struct CategoryModel {
    let image: UIImage
    let title: String
}

extension CategoryModel {
    
    static func categoryModelData() -> [CategoryModel] {
        return [
            CategoryModel(image: Image.allCategory, title: "전체"),
            CategoryModel(image: Image.book, title: "도서"),
            CategoryModel(image: Image.charger, title: "전자기기"),
            CategoryModel(image: Image.charger, title: "배달"),
            CategoryModel(image: Image.book, title: "벌레"),
            CategoryModel(image: Image.other, title: "기타")
        ]
    }
    
    static func selectedCategoryModelData() -> [CategoryModel] {
        return [
            CategoryModel(image: Image.selectedAllCategory, title: "전체"),
            CategoryModel(image: Image.selectedBook, title: "도서"),
            CategoryModel(image: Image.selectedCharger, title: "전자기기"),
            CategoryModel(image: Image.selectedCharger, title: "배달"),
            CategoryModel(image: Image.selectedBook, title: "벌레"),
            CategoryModel(image: Image.selectedOther, title: "기타")
        ]
    }
}
