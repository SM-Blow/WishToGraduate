//
//  BorrowLabel.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/11.
//

import UIKit

final class CommonBorrowLabel: UILabel {

    // MARK: - Properties
    
    private var padding = UIEdgeInsets(top: 5, left: 13, bottom: 5, right: 13)

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.right + padding.left
        return contentSize
    }
}

private extension CommonBorrowLabel {
    func setUI() {
        font = .fontGuide(.bt1)
        textColor = .black
        textAlignment = .center
        backgroundColor = Color.btn_LightGreen
        layer.cornerRadius = 14
        clipsToBounds = true
    }
}
