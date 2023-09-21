//
//  CouponAddCollectionViewCell.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/21.
//

import UIKit

import SnapKit
import Then

final class CouponAddCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    private let addCouponLabel = UILabel()
    private let addButton = UIButton()
    
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

extension CouponAddCollectionViewCell {
    private func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = Color.btn_darkGrey.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = false
        
        addCouponLabel.do {
            $0.text = "쿠폰 추가하기"
            $0.font = .fontGuide(.h4)
            $0.textAlignment = .center
        }
        addButton.setImage(Image.ic_plus, for: .normal)
    }
    
    private func setLayout() {
        contentView.addSubviews(addButton, addCouponLabel)
        
        addButton.snp.makeConstraints {
            $0.size.equalTo(35)
            $0.top.equalToSuperview().inset(7)
            $0.centerX.equalToSuperview()
        }
        
        addCouponLabel.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }
}
