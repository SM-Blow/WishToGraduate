//
//  CouponCollectionViewCell.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/21.
//

import UIKit

import SnapKit
import Then

final class CouponCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    
    private let couponTitleLabel = UILabel()
    private let couponContentLabel = UILabel()
    private let untilLabel = UILabel()
    private let timeoutLabel = UILabel()
    
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

extension CouponCollectionViewCell {
    private func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = Color.btn_darkGrey.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = false
        
        couponTitleLabel.font = .fontGuide(.m1)
        
        [couponContentLabel, timeoutLabel].forEach {
            $0.font = .fontGuide(.date1)
            $0.textColor = Color.date_Grey
        }
        
        couponContentLabel.font = .fontGuide(.date1)
        untilLabel.do {
            $0.font = .fontGuide(.date1)
            $0.textColor = Color.main2_Green
            $0.text = "Until"
        }
    }

    private func setLayout() {
        contentView.addSubviews(couponTitleLabel, couponContentLabel, untilLabel, timeoutLabel)
        
        couponTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }
        
        couponContentLabel.snp.makeConstraints {
            $0.top.equalTo(couponTitleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(15)
        }
        
        timeoutLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(15)
        }
        
        untilLabel.snp.makeConstraints {
            $0.trailing.equalTo(timeoutLabel.snp.leading).offset(-7)
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    func setData(_ model: Coupon) {
        couponTitleLabel.text = model.storeName
        couponContentLabel.text = model.content
        timeoutLabel.text =
        "\(model.dueDate[0]).\(model.dueDate[1]).\(model.dueDate[2])"
    }
}
