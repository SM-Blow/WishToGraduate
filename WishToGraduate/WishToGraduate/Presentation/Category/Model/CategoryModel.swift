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
            CategoryModel(image: Image.pill, title: "약"),
            CategoryModel(image: Image.sanitaryPad, title: "생리대"),
            CategoryModel(image: Image.charger, title: "전자기기"),
            CategoryModel(image: Image.book, title: "도서"),
            CategoryModel(image: Image.charger2, title: "전자기기")
        ]
    }
}
