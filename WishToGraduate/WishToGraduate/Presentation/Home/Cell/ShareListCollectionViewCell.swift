//
//  HomeListTableViewCell.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/16.
//

import UIKit

import Moya
import SnapKit
import Then

final class ShareListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let borrowLabel = CommonBorrowLabel()
    private let transactionLabel = UILabel()
    private let timeLabel = UILabel()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShareListCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = Color.btn_darkGrey.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = false
        
        titleLabel.do {
            $0.font = .fontGuide(.m1)
            $0.textColor = .black
            $0.addCharacterSpacing()
        }
        
//        borrowLabel.do {
//            $0.font = .fontGuide(.bt1)
//            $0.textColor = .black
//            $0.textAlignment = .center
//            $0.backgroundColor = Color.btn_LightGreen
//            $0.layer.cornerRadius = 12
//            $0.clipsToBounds = true
//        }
        
        transactionLabel.do {
            $0.text = "거래중"
            $0.font = .fontGuide(.bt1)
            $0.textColor = .white
            $0.textAlignment = .center
            $0.backgroundColor = Color.main_Green
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
        }
        
        timeLabel.do {
            $0.font = .fontGuide(.date1)
            $0.textColor = .black
            $0.addCharacterSpacing()
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(titleLabel, borrowLabel, transactionLabel, timeLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(14)
        }
        
        borrowLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(9)
//            $0.width.equalTo(43)
//            $0.height.equalTo(22)
        }
        
        transactionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(borrowLabel.snp.trailing).offset(6)
            $0.width.equalTo(37)
            $0.height.equalTo(18)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }
    }
    
    // MARK: - Methods
    
    func setDataBind(model: ShareListModel) {
        titleLabel.text = model.title
        borrowLabel.text = model.borrow == 1 ? "빌려요" : "빌려줄게요"
        transactionLabel.isHidden = model.transaction
        timeLabel.text = model.time
    }
    
    // MARK: - @objc Methods
}
