//
//  BorrowLabel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/22.
//

import UIKit

class BorrowLabel: UILabel {
    
    private var width: CGFloat = 0
    private let height: CGFloat = 22

    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override var intrinsicContentSize: CGSize {
        let width = self.width > 0 ? width : super.intrinsicContentSize.width
        let height = self.height > 0 ? height : super.intrinsicContentSize.height
        return CGSize(width: width, height: height)
    }
}

extension BorrowLabel {
    
    func setUI() {
        font = .fontGuide(.bt1)
        textColor = .black
        textAlignment = .center
        backgroundColor = Color.btn_LightGreen
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    func labelStatus(status: LabelStatus) {
        switch (status) {
        case .borrow:
            self.width = 43
        case .lend:
            self.width = 60
        }
    }
}


