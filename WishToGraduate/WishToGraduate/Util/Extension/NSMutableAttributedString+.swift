//
//  NSMutableAttributedString+.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/05.
//

import UIKit

extension NSMutableAttributedString {
    /// target: 대상 문자열, Figma의 heightMultiple = lineHeightMultiple 값
    func lineSapcing(_ target: String, heightMultiple: CGFloat) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = heightMultiple
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style
        ]
        
        self.append(NSAttributedString(string: target, attributes:attributes))
        return self
    }
}
