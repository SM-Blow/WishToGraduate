//
//  BorrowTypeCollectionViewCell.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/11.
//

import UIKit

import SnapKit
import Then

final class BorrowTypeCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Components
    
    private let borrowLabel = CommonBorrowLabel(frame: .zero)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BorrowTypeCollectionViewCell {
    private func setUI() {
        contentView.backgroundColor = .clear
        borrowLabel.font = .fontGuide(.h2_bold)
        borrowLabel.backgroundColor = Color.line_Grey
    }
    
    private func setLayout() {
        contentView.addSubview(borrowLabel)
        borrowLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setDataBind(_ model: BorrowTypeModel) {
        borrowLabel.setText(model.type)
    }

    func setBackgroundColor() {
        borrowLabel.backgroundColor = isSelected ? Color.btn_LightGreen : Color.line_Grey
    }
}
