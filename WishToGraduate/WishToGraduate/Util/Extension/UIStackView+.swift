//
//  UIStackView+.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/04.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {  self.addArrangedSubview($0) }
    }
}
